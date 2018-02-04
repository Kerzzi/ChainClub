class Account::JobsController < ApplicationController
  before_action :authenticate_user!

  def index
    @jobs = current_user.jobs.recent.paginate(:page => params[:page], :per_page => 10)
    @favorite_jobs = current_user.favorite_jobs.recent.paginate(:page => params[:page], :per_page => 10)
  end
end
