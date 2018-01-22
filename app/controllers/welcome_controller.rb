class WelcomeController < ApplicationController
  def index
    
    @online_meetups = MeetupGroup.all.online_meetup.paginate(:page => params[:page], :per_page => 5)
    @offline_meetups = MeetupGroup.all.offline_meetup.paginate(:page => params[:page], :per_page => 5)
    @internship_jobs = Job.published.recent.internship_job.paginate(:page => params[:page], :per_page => 4)
    @fulltime_jobs = Job.published.recent.fulltime_job.paginate(:page => params[:page], :per_page => 4)
    
    
  end
end
