class TopicsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy, :favorite, :unfavorite, :follow, :unfollow,
                                            :action, :favorites]

  before_action :find_topic, only: [ :ban, :edit, :update, :destroy, :follow,
                                   :unfollow, :action,] 
   
  def index
    @topics = Topic.all.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @topic = Topic.find(params[:id])
    @user = @topic.user
    @answers = @topic.answers
  end
    
  def new 
    @topic = Topic.new(user_id: current_user.id)
    unless params[:node].blank?
      @topic.node_id = params[:node]
      @node = Node.find_by_id(params[:node])
      render_404 if @node.blank?
    end
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
  
  def edit
    @topic = Topic.find(params[:id])
    @node = @topic.node
  end

  def update
    @topic = Topic.find(params[:id])
    
    @topic.node_id = topic_params[:node_id]

    if @topic.update(topic_params)
      redirect_to topics_path, notice: "该提问已更新成功!"
    else 
      render :edit 
    end
  end

  def destroy
    @topic.destroy
  
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

  def node
    @node = Node.find(params[:id])
    @topics = @node.topics.all
    @topics = @topics.includes(:user).page(params[:page])
    @page_title = "#{@node.name} &raquo; #{t('menu.topics')}"
    @page_title = [@node.name, t("menu.topics")].join(" · ")
    render action: "index"
  end


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

  private
  def find_topic
    @topic ||= Topic.find(params[:id])
  end  
 
  def topic_params
    params.require(:topic).permit(:title, :content, :node_id)
  end  
end
