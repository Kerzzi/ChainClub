class WelcomeController < ApplicationController
  def index
    @official_articles = OfficialArticle.where(:status => "public").order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
    @article_hots = OfficialArticle.where(:status => "public").sort_by{|official_article| -official_article.article_comments.count}

    @online_meetups = MeetupGroup.all.online_meetup.paginate(:page => params[:page], :per_page => 3)
    @offline_meetups = MeetupGroup.all.offline_meetup.paginate(:page => params[:page], :per_page => 3)
    @internship_jobs = Job.published.recent.internship_job.paginate(:page => params[:page], :per_page => 3)
    @fulltime_jobs = Job.published.recent.fulltime_job.paginate(:page => params[:page], :per_page => 3)

  end

  def about
    # render layout: false
  end
end
