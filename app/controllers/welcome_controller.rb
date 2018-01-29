class WelcomeController < ApplicationController
  def index
    @official_articles = OfficialArticle.where(:status => "public").order("created_at DESC").paginate(:page => params[:page], :per_page => 7)
    @article_hots = OfficialArticle.where(:status => "public").paginate(:page => params[:page], :per_page => 7).sort_by{|official_article| -official_article.article_comments.count}
    @topics = Topic.published.paginate(:page => params[:page], :per_page => 8)
    @groups = Group.published.recent.paginate(:page => params[:page], :per_page => 6)
    @projects = Project.published.recent.paginate(:page => params[:page], :per_page => 4)
    @courses = Course.published.paginate(:page => params[:page], :per_page => 8) 

    @online_meetups = MeetupGroup.all.online_meetup.paginate(:page => params[:page], :per_page => 3)
    @offline_meetups = MeetupGroup.all.offline_meetup.paginate(:page => params[:page], :per_page => 3)
    @internship_jobs = Job.published.recent.internship_job.paginate(:page => params[:page], :per_page => 3)
    @fulltime_jobs = Job.published.recent.fulltime_job.paginate(:page => params[:page], :per_page => 3)

  end

  def about
    # render layout: false
  end
end
