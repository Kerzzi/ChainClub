class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @jobs = Job.all.paginate(:page => params[:page], :per_page => 10) 
  end  
  
  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end  
  
  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end 
  end
  
  def update 
    @job = Job.find(params[:id])
      
    if @job.update(job_params)
      redirect_to jobs_path, notice:"更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy  
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path, alert: "删除成功！"
  end

  private
 
  def job_params
    params.require(:job).permit(:title, :city, :publisher, :benefit, :introduce, :demand, :deadline, :process, :user_id)
  end
end
