class WelcomeController < ApplicationController
  def index
    

    @internship_jobs = Job.published.recent.internship_job.paginate(:page => params[:page], :per_page => 4)
    @fulltime_jobs = Job.published.recent.fulltime_job.paginate(:page => params[:page], :per_page => 4)
    
    
  end
end
