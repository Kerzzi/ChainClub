class Admin::ProjectsController < Admin::BaseController
  before_action :require_editor!

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
      redirect_to admin_projects_path
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to admin_projects_path, notice:"更新成功！"
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to admin_projects_path, alert: "删除成功！"
  end

  def bulk_update
    total = 0
    Array(params[:ids]).each do |project_id|
      project = Project.find(project_id)
      project.destroy
      total += 1
    end

    flash[:alert] = "成功完成 #{total} 笔"
    redirect_to admin_projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :ico_start, :ico_end, :ico_url, :website, :slack, :facebook, :telegram,
      :twitter, :weibo, :github, :ico_amount, :whitepaper, :token_amount, :raised_ceiling, :accept_token,
        :token_type,  :introduce, :user_id)
  end
end
