class CoursesController < ApplicationController
  before_action :validate_search_key, only: [:search]
  
  def index
    @courses = Course.published.paginate(:page => params[:page], :per_page => 10) 
  end  
  
  def show
    @course = Course.find(params[:id])
  end
  
  def search
     if @query_string.present?
       search_result = Course.ransack(@search_criteria).result(:distinct => true)
       @courses = search_result.paginate(:page => params[:page], :per_page => 15 )
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
     
end
