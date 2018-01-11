class Admin::JobsController < Admin::BaseController
  before_action :require_editor!
  
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
      redirect_to admin_jobs_path
    else
      render :new
    end 
  end
  
  def update 
    @job = Job.find(params[:id])
      
    if @job.update(job_params)
      redirect_to admin_jobs_path, notice:"更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy  
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to admin_jobs_path, alert: "删除成功！"
  end

  def bulk_update
    total = 0
    Array(params[:ids]).each do |job_id|
      job = Job.find(job_id)
      job.destroy
      total += 1
    end

    flash[:alert] = "成功完成 #{total} 笔"
    redirect_to admin_jobs_path
  end

  def publish
    @job = Job.find(params[:id])
    @job.is_hidden = false
    @job.save
    redirect_to admin_jobs_path
  end

  def hide
    @job = Job.find(params[:id])
    @job.is_hidden = true
    @job.save
    redirect_to admin_jobs_path
  end
  
  private
 
  def job_params
    params.require(:job).permit(:title, :is_hidden, :city, :publisher, :benefit, :introduce, :demand, :deadline, :process, :user_id)
  end
end
