class Admin::TopicsController < Admin::BaseController
  def index
    @topics = Topic.all.paginate(:page => params[:page], :per_page => 10) 
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(params[:topic].permit!)

    if @topic.save
      redirect_to(admin_topics_path, notice: "Topic was successfully created.")
    else
      render action: "new"
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(params[:topic].permit!)
      redirect_to(admin_topics_path, notice: "Topic was successfully updated.")
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

end
