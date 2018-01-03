class TopicsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  before_action :find_topic, only: [ :edit, :update, :destroy] 
   
  def index
    @topics = Topic.all
  end
  
  def show
    @topic = Topic.find(params[:id])
    @answers = @topic.answers.paginate(:page => params[:page], :per_page => 5)
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


  def node
    @node = Node.find(params[:id])
    @topics = @node.topics.all
    @topics = @topics.includes(:user).page(params[:page])
    @page_title = "#{@node.name} &raquo; #{t('menu.topics')}"
    @page_title = [@node.name, t("menu.topics")].join(" · ")
    render action: "index"
  end

  private
  def find_topic
    @topic ||= Topic.find(params[:id])
  end  
 
  def topic_params
    params.require(:topic).permit(:title, :content, :node_id)
  end  
end
