class PostCommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :find_group_post_and_check_permission, only: [:edit, :update, :destroy]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.post = @post
    @post_comment.user = current_user

    if @post_comment.save
      redirect_to group_post_path(@group,@post)
    else
      render :new
    end
  end

  def edit 
  end
  
  def update  
    if @post_comment.update(post_comment_params)
      redirect_to group_post_path(@group,@post), notice:"更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy  
    @post_comment.destroy
    redirect_to group_post_path(@group,@post), alert: "删除成功！"
  end
  
  private

  def find_group_post_and_check_permission
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])

    if current_user != @post_comment.user
      redirect_to group_post_path(@group,@post), alert: "抱歉，您没有相应的权限！"
    end
  end
  
  def post_comment_params
    params.require(:post_comment).permit(:content,:is_hidden)
  end
    
end
