class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]
  
  def index
    @groups = Group.all
  end  
  
  def show
    @group = Group.find(params[:id])
    @posts = case params[:order]
             when 'by_hot'
               #按评论数量排序
               @group.posts.sort_by{|post| -post.post_comments.count}    
             
             else
               @group.posts.recent.paginate(:page => params[:page], :per_page => 10)
             end 
  end

  def edit
  end  
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    
    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end 
  end
  
  def update  
    if @group.update(group_params)
      redirect_to groups_path, notice:"更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy  
    @group.destroy
    redirect_to groups_path, alert: "删除成功！"
  end
 
  def join
   @group = Group.find(params[:id])
  
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "成功加入该小组！"
    else
      flash[:warning] = "你已经是本讨论版成员了！"
    end
  
    redirect_to group_path(@group)
  end
  
  def quit
    @group = Group.find(params[:id])
  
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已退出本讨论版！"
    else
      flash[:warning] = "你不是本讨论版成员，怎么退出 XD"
    end
  
    redirect_to group_path(@group)
  end
 
 
  private

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: "抱歉，您没有相应的权限！"
    end
  end
 
  def group_params
    params.require(:group).permit(:title, :logo, :remove_logo, :description)
  end  
  
end
