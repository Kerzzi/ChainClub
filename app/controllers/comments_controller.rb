class CommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]
  before_action :find_group_post_comment_and_check_permission, only: [:edit, :update, :destroy]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      redirect_to group_post_path(@group,@post)
    else
      render :new
    end
  end
  
  def edit 
  end
  
  def update  
    if @comment.update(comment_params)
      redirect_to group_post_path(@group,@post), notice:"更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy  
    @comment.destroy
    redirect_to group_post_path(@group,@post), alert: "删除成功！"
  end

  private
  def find_group_post_comment_and_check_permission
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    if (current_user != @comment.user) && (current_user !=@post.user)
      redirect_to group_post_path(@group,@post), alert: "抱歉，您没有相应的权限！"
    end
  end
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end
