class TopicsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy, :favorite, :unfavorite, :follow, :unfollow,
                                            :action, :favorites]

  before_action :find_topic, only: [ :ban, :edit, :update, :destroy, :follow,
                                   :unfollow, :action,]
  before_action :validate_search_key, only: [:search]

  def index
    @topics = Topic.all.paginate(:page => params[:page], :per_page => 10)
  end

  def node
    @node = Node.find(params[:id])
    @topics = @node.topics.all
    @topics = @topics.includes(:user).page(params[:page])
    @page_title = "#{@node.name} &raquo; #{t('menu.topics')}"
    @page_title = [@node.name, t("menu.topics")].join(" · ")
    render action: "index"
  end

  # GET /topics/favorites
  def favorites
    @topics = current_user.favorite_topics.includes(:user)
    @topics = @topics.page(params[:page])
    render action: "index"
  end

  def excellent
    @topics = Topic.excellent.recent.fields_for_list.includes(:user)
    @topics = @topics.page(params[:page])

    @page_title = [t("topics.topic_list.excellent"), t("menu.topics")].join(" · ")
    render action: "index"
  end

  def show
    @topic = Topic.unscoped.includes(:user).find(params[:id])
    @commends = Topic.where.not(:id => @topic.id ).random5

    @node = @topic.node
    @user = @topic.user
    # @answers = @topic.answers
    @answers = Answer.unscoped.where(topic_id: @topic.id).order(:id).all
  end

  def new
    @topic = Topic.new(user_id: current_user.id)
    unless params[:node].blank?
      @topic.node_id = params[:node]
      @node = Node.find_by_id(params[:node])
      render_404 if @node.blank?
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    @node = @topic.node
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    @topic.node_id = params[:node] || topic_params[:node_id]

    if @topic.save
      redirect_to topics_path
    else
      render :new
    end
  end

  def preview
    @content = params[:content]

    respond_to do |format|
      format.json
    end
  end

  def update
    @topic = Topic.find(params[:id])

    @topic.node_id = topic_params[:node_id]

    if @topic.update(topic_params)
      redirect_to topic_path(@topic), notice: "该提问已更新成功!"
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy_by(current_user)

    redirect_to topics_path, alert: "该提问已被删除！"
  end


  # ---topic收藏文章---
  def like
    @topic = Topic.find(params[:id])

    if !current_user.is_fan_of?(@topic)
      current_user.like_topic!(@topic)
    end
      redirect_to topic_path(@topic)
  end

  def unlike
    @topic = Topic.find(params[:id])

    if current_user.is_fan_of?(@topic)
      current_user.unlike_topic!(@topic)
    end
      redirect_to topic_path(@topic)
  end



  def favorite
    current_user.favorite_topic(params[:id])
    render plain: "1"
  end

  def unfavorite
    current_user.unfavorite_topic(params[:id])
    render plain: "1"
  end

  def follow
    current_user.follow_topic(@topic)
    render plain: "1"
  end

  def unfollow
    current_user.unfollow_topic(@topic)
    render plain: "1"
  end

  def action
    authorize! params[:type].to_sym, @topic

    case params[:type]
    when "excellent"
      @topic.excellent!
      redirect_to @topic, notice: "加精成功。"
    when "unexcellent"
      @topic.unexcellent!
      redirect_to @topic, notice: "加精已经取消。"
    when "ban"
      params[:reason_text] ||= params[:reason] || ""
      @topic.ban!(reason: params[:reason_text].strip)
      redirect_to @topic, notice: "已转移到 NoPoint 节点。"
    when "close"
      @topic.close!
      redirect_to @topic, notice: "话题已关闭，将不再接受任何新的回复。"
    when "open"
      @topic.open!
      redirect_to @topic, notice: "话题已重启开启。"
    end
  end

  def ban
    authorize! :ban, @topic
  end


   def search
     if @query_string.present?
       search_result = Topic.ransack(@search_criteria).result(:distinct => true)
       @topics = search_result.paginate(:page => params[:page], :per_page => 15 )
     end
   end


   protected

   # 取到params[:q]的内容并去掉非法的内容
   def validate_search_key
     @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
     @search_criteria = search_criteria(@query_string)
   end


   def search_criteria(query_string)
     { :title_cont => query_string }
   end

  private
  def find_topic
    @topic ||= Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :content, :node_id)
  end

  def check_current_user_status_for_topic
    return false unless current_user

    # 是否关注过
    @has_followed = current_user.follow_topic?(@topic)
    # 是否收藏
    @has_favorited = current_user.favorite_topic?(@topic)
  end

end
