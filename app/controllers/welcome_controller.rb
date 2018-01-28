class WelcomeController < ApplicationController
  def index

    @online_meetups = MeetupGroup.all.online_meetup.paginate(:page => params[:page], :per_page => 3)
    @offline_meetups = MeetupGroup.all.offline_meetup.paginate(:page => params[:page], :per_page => 3)
    @internship_jobs = Job.published.recent.internship_job.paginate(:page => params[:page], :per_page => 3)
    @fulltime_jobs = Job.published.recent.fulltime_job.paginate(:page => params[:page], :per_page => 3)

  end

  def about
    # render layout: false
  end
end
