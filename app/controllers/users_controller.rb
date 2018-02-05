class UsersController < ApplicationController

  before_action :authenticate_user!

  def show  
    
    if User.find_by_id(params[:id])
      @user = User.find(params[:id])
      @user.create_profile unless @user.profile
      @groups = @user.groups.recent.paginate(:page => params[:page], :per_page => 10)
      @participated_groups = @user.participated_groups.recent.paginate(:page => params[:page], :per_page => 10)
      @posts = @user.posts.recent.paginate(:page => params[:page], :per_page => 10)
      @favorite_posts = @user.favorite_posts.recent.paginate(:page => params[:page], :per_page => 10)
      @topics = @user.topics.recent.paginate(:page => params[:page], :per_page => 10)
      @liked_topics = @user.liked_topics.recent.paginate(:page => params[:page], :per_page => 10)
    else
      redirect_to root_path
    end
    
  end


end
