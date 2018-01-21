class Admin::CoursesController < Admin::BaseController
  before_action :require_editor!

  def index
    @courses = Course.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @course = Course.find(params[:id])
  end

  def edit
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.user = current_user

    if @course.save
      redirect_to admin_courses_path
    else
      render :new
    end
  end

  def update
    @course = Course.find(params[:id])

    if @course.update(course_params)
      redirect_to admin_courses_path, notice:"更新成功！"
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to admin_courses_path, alert: "删除成功！"
  end

  def bulk_update
    total = 0
    Array(params[:ids]).each do |course_id|
      course = Course.find(course_id)
      course.destroy
      total += 1
    end

    flash[:alert] = "成功完成 #{total} 笔"
    redirect_to admin_courses_path
  end

  private

  def course_params
    params.require(:course).permit(:title, :quantity, :logo, :remove_logo, :introduce, :lecturer, :price, :msrp, :url, :user_id)
  end
end
