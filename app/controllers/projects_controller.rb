class ProjectsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  def index
    @projects = Project.all.paginate(:page => params[:page], :per_page => 10)
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

  private

  def project_params
    params.require(:project).permit(:title, :logo, :remove_logo, :ico_start, :ico_end, :ico_url, :website, :slack, :facebook, :telegram,
      :twitter, :weibo, :github, :ico_amount, :whitepaper, :token_amount, :raised_ceiling, :grade, :accept_token,
        :token_type,  :introduce,  :rating_report,  :user_id)
  end
end
