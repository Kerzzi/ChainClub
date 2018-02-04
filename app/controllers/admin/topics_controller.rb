class Admin::TopicsController < Admin::BaseController
  def index
    @topics = Topic.all.recent.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def node
    @node = Node.find(params[:id])
    @topics = @node.topics.all
    @topics = @topics.includes(:user).page(params[:page])
    @page_title = "#{@node.name} &raquo; #{t('menu.topics')}"
    @page_title = [@node.name, t("menu.topics")].join(" · ")
    render action: "index"
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
  end

  def create
    @topic = Topic.new(params[:topic].permit!)
    @topic.user_id = current_user.id
    @topic.node_id = params[:node] || topic_params[:node_id]

    if @topic.save
      redirect_to(admin_topics_path, notice: "话题创建成功！")
    else
      render action: "new"
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(params[:topic].permit!)
      redirect_to(admin_topics_path, notice: "该话题已更新成功!")
    else
      render action: "edit"
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy_by(current_user)

    redirect_to(admin_topics_path)
  end

  def suggest
    @topic.update_attribute(:suggested_at, Time.now)
    redirect_to(@topic, notice: "Topic:#{params[:id]} suggested.")
  end

  def unsuggest
    @topic.update_attribute(:suggested_at, nil)
    redirect_to(@topic, notice: "Topic:#{params[:id]} unsuggested.")
  end

  def bulk_update
    total = 0
    Array(params[:ids]).each do |topic_id|
      topic =  Topic.find(topic_id)
      topic.destroy
      total += 1
    end

    flash[:alert] = "成功完成 #{total} 笔"
    redirect_to admin_topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :status, :content, :node_id)
  end

end
