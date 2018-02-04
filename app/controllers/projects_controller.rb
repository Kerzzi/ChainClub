class ProjectsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :unfavorite, :favorite]
  before_action :validate_search_key, only: [:search]

  def index
    @projects = Project.published.recent.paginate(:page => params[:page], :per_page => 28)
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end


  # --收藏功能---
  def favorite
    @project = Project.find(params[:id])

    if !current_user.is_favor_of_project?(@project)
      current_user.favorite_project!(@project)
    end
      redirect_to project_path(@project)
  end

  def unfavorite
    @project = Project.find(params[:id])

    if current_user.is_favor_of_project?(@project)
      current_user.unfavorite_project!(@project)
    end
      redirect_to project_path(@project)
  end
  
   def search
     if @query_string.present?
       search_result = Project.ransack(@search_criteria).result(:distinct => true)
       @projects = search_result.paginate(:page => params[:page], :per_page => 15 )
     end
   end


   protected

   # 取到params[:q]的内容并去掉非法的内容
   def validate_search_key
     @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
     @search_criteria = search_criteria(@query_string)
   end


   def search_criteria(query_string)
     { :title_cont => query_string }
   end

  private

  def project_params
    params.require(:project).permit(:title, :status, :logo, :remove_logo, :ico_start, :ico_end, :ico_url, :website, :slack, :facebook, :telegram,
      :twitter, :weibo, :github, :ico_amount, :whitepaper, :token_amount, :raised_ceiling, :grade, :accept_token,
        :token_type,  :introduce,  :rating_report,  :user_id)
  end
end
