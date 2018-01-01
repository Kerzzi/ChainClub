class Admin::ProjectGradesController < Admin::BaseController
  before_action :require_editor!
  before_action :find_project_and_project_grade

  def edit
  end

  def update
    if @project_grade.update(project_grade_params)
      redirect_to admin_projects_path
    else
      render "edit"
    end
  end

  protected

  def find_project_and_project_grade
    @project = Project.find(params[:project_id])
    # 因为新建的用户并没有 create_project_grade，所以这里先检查是否有 @project.create_project_grade，如果没有的话就用 @project.create_project_grade 新建进数据库
    @project_grade = @project.project_grade || @project.create_project_grade
  end

  def project_grade_params
    params.require(:project_grade).permit(:rating_report, :grade)
  end
end
