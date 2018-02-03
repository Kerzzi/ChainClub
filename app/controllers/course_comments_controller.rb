class CourseCommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @course = Course.find(params[:course_id])
    @course_comment = CourseComment.new
  end

  def create
    @course = Course.find(params[:course_id])
    @course_comment = CourseComment.new(course_comment_params)
    @course_comment.course = @course
    @course_comment.user = current_user

    if @course_comment.save
      redirect_to course_path(@course)
    else
      render :new
    end
  end


  def destroy
    @course = Course.find(params[:course_id])
    @course_comment = CourseComment.find(params[:id])
    @course_comment.destroy
    redirect_to course_path(@course), alert: "删除成功！"
  end

  private

  def course_comment_params
    params.require(:course_comment).permit(:content)
  end
end
