class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end  
  
  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end  
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.save
 
    redirect_to groups_path
  end
  
  def update
    @group = Group.find(params[:id])
    
    @group.update(group_params)
    
    redirect_to groups_path, notice:"更新成功！"
  end
 
  private
 
  def group_params
    params.require(:group).permit(:title, :description)
  end  
  
end
