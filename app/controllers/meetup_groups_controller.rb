class MeetupGroupsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]
  before_action :find_meetup_group_and_check_permission, only: [:edit, :update, :destroy]  
  
  def index
    @meetup_groups = MeetupGroup.all.paginate(:page => params[:page], :per_page => 5) 
  end

  def new
    @meetup_group = MeetupGroup.new
  end

  def create
    @meetup_group = MeetupGroup.new(meetup_group_params)
    @meetup_group.user = current_user

    if @meetup_group.save
      redirect_to meetup_groups_path
    else
      render :new
    end
  end
  
  def show
    @meetup_group = MeetupGroup.find(params[:id])
  end

  def edit
  end  
    
  def update  
    if @meetup_group.update(meetup_group_params)
      redirect_to meetup_groups_path, notice:"更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy  
    @meetup_group.destroy
    redirect_to meetup_groups_path, alert: "删除成功！"
  end  

  private
  def find_meetup_group_and_check_permission
    @meetup_group = MeetupGroup.find(params[:id])

    if current_user != @meetup_group.user
      redirect_to meetup_group_path, alert: "抱歉，您没有相应的权限！"
    end
  end
  
  def meetup_group_params
    params.require(:meetup_group).permit(:title, :meetup_type, :time_limit, :activity_time, :city, :address, :register, :introduce, :user_id)
  end

end
