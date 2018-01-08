class OfficialArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :join, :quit]
  
  # ---CRUD---
  def index
    @official_articles = OfficialArticle.where(:status => "public").order("created_at DESC").paginate(:page => params[:page], :per_page => 5) 
  end
  
  def show
    @official_article = OfficialArticle.find(params[:id])
    @user = @official_article.user
    @userarticles = @official_article.user.official_articles.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
    @article_comments = @official_article.article_comments.order("created_at DESC")
    @article_comment = ArticleComment.new

    @article_hots = OfficialArticle.where(:status => "public").sort_by{|official_article| -official_article.article_comments.count}    #按数据要求排序
    
    if @official_article.status != "public"
      flash[:warning] = "这篇文章在审核中！不可查看！"
      redirect_to root_path
    end
  end
  
  def new
    @official_article = OfficialArticle.new 
  end
  
  def create
    @official_article = OfficialArticle.new(official_article_params)
    @official_article.user = current_user
    
    if @official_article.save
      redirect_to official_articles_path
      flash[:notice] = "文章已提交，待管理员审核后可发布"
    else
      render :new 
    end
  end
  
  def edit 
    @official_article = OfficialArticle.find(params[:id])
  end
  
  def update
    @official_article = OfficialArticle.find(params[:id])
    
    if @official_article.update(official_article_params)    
      redirect_to official_articles_path, notice: "文章更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy
    @official_article = OfficialArticle.find(params[:id])
    @official_article.destroy
    redirect_to official_articles_path, alert: "文章已删除"
  end
  
  # ---official_article_collection 收藏文章---
  
  # ---official_article_collection 喜欢文章---
  def like
    @official_article = OfficialArticle.find(params[:id])

    if !current_user.is_fan_of?(@official_article)
      current_user.like_official_article!(@official_article)
    end
      redirect_to official_article_path(@official_article)
  end

  def unlike
    @official_article = OfficialArticle.find(params[:id])

    if current_user.is_fan_of?(@official_article)
      current_user.unlike_official_article!(@official_article)
    end
      redirect_to official_article_path(@official_article)
  end

  private
  
  def official_article_params
    params.require(:official_article).permit(:title, :content,:summary,:image, :user_id, :author, :source, :article_category_id, :status)
  end
end
