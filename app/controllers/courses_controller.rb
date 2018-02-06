class CoursesController < ApplicationController
  before_action :validate_search_key, only: [:search]
  before_action :authenticate_user! , only: [:favorite, :unfavorite]

  def index
    @courses = Course.published.recent.paginate(:page => params[:page], :per_page => 28) 
  end

  def show
    @course = Course.find(params[:id])
    set_page_title @course.title
    set_page_description "#{@course.introduce}"
    @course_comment = CourseComment.new
    @course_comments = @course.course_comments.recent.paginate(:page => params[:page], :per_page => 10)
  end

  def search
     if @query_string.present?
       search_result = Course.ransack(@search_criteria).result(:distinct => true)
       @courses = search_result.paginate(:page => params[:page], :per_page => 15 )
     end
   end

   # --收藏课程---
   def favorite
     @course = Course.find(params[:id])

     if !current_user.is_favor_of_course?(@course)
       current_user.favorite_course!(@course)
     end
       redirect_to course_path(@course)
   end

   def unfavorite
     @course = Course.find(params[:id])

     if current_user.is_favor_of_course?(@course)
       current_user.unfavorite_course!(@course)
     end
       redirect_to course_path(@course)
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

end
