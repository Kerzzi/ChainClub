class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :find_group_post_and_check_permission, only: [:edit, :update, :destroy]

  def show
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(:page => params[:page], :per_page => 10)
  end
  
  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  
  def edit 
  end
  
  def update  
    if @post.update(post_params)
      redirect_to group_path(@group), notice:"更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy  
    @post.destroy
    redirect_to group_path(@group), alert: "删除成功！"
  end


  private
  def find_group_post_and_check_permission
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])

    if current_user != @post.user
      redirect_to root_path, alert: "抱歉，您没有相应的权限！"
    end
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end  
end
