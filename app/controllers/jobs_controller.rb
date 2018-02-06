class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :favorite, :unfavorite]
  before_action :validate_search_key, only: [:search]

  def index
    @jobs = case params[:order]
            when 'by_deadline'
              Job.published.deadline.paginate(:page => params[:page], :per_page => 10)
            when 'by_internship'
              Job.published.recent.internship_job.paginate(:page => params[:page], :per_page => 10)
            when 'by_fulltime'
              Job.published.recent.fulltime_job.paginate(:page => params[:page], :per_page => 10)
            else
              Job.published.recent.paginate(:page => params[:page], :per_page => 10)
            end
  end

  def show
    @job = Job.find(params[:id])
    set_page_title @job.title
    set_page_description "#{@job.introduce}"    
    # 随机推荐5个相同类型的职位（去除当前职位） #
    @commends = Job.published.where.not(:id => @job.id ).random5

    if @job.is_hidden
      flash[:warning] = "该项目已归档！"
      redirect_to jobs_path
    end
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

  def search
    if @query_string.present?
      search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 10 )
    end
  end

  # --收藏功能---
  def favorite
    @job = Job.find(params[:id])

    if !current_user.is_favor_of_job?(@job)
      current_user.favorite_job!(@job)
    end
      redirect_to job_path(@job)
  end

  def unfavorite
    @job = Job.find(params[:id])

    if current_user.is_favor_of_job?(@job)
      current_user.unfavorite_job!(@job)
    end
      redirect_to job_path(@job)
  end
  
  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_cont => query_string }
  end
  
  private

  def job_params
    params.require(:job).permit(:title, :is_hidden, :category, :city, :publisher, :benefit, :introduce, :demand, :deadline, :process, :user_id)
  end
  
end
