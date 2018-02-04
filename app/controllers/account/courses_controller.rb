class Account::CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = current_user.courses.recent.paginate(:page => params[:page], :per_page => 10)
    @favorite_courses = current_user.favorite_courses.recent.paginate(:page => params[:page], :per_page => 10)
  end
end
