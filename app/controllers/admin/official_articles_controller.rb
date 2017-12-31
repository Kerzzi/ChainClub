class Admin::OfficialArticlesController < Admin::BaseController
  before_action :require_editor!
  
  def index
    @official_articles = OfficialArticle.all.paginate(:page => params[:page], :per_page => 5) 
  end
  
  def show
    @official_article = OfficialArticle.find(params[:id])
    @article_comments = @official_article.article_comments
  end
  
  def new
    @official_article = OfficialArticle.new 
  end
  
  def create
    @official_article = OfficialArticle.new(official_article_params)
    if @official_article.save
      redirect_to admin_official_articles_path
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
      redirect_to admin_official_articles_path, notice: "文章更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy
    @official_article = OfficialArticle.find(params[:id])
    @official_article.destroy
    redirect_to admin_official_articles_path, alert: "文章已删除"
  end

  def bulk_update
    total = 0
    Array(params[:ids]).each do |official_article_id|
      official_article = OfficialArticle.find(official_article_id)
      if params[:commit] == I18n.t(:bulk_update)
        official_article.status = params[:official_article_status]
        if official_article.save
          total += 1
        end
      elsif params[:commit] == I18n.t(:bulk_delete)
        official_article.destroy
        total += 1
      end
    end

    flash[:alert] = "成功完成 #{total} 笔"
    redirect_to admin_official_articles_path
  end
  
  private
  
  def official_article_params
    params.require(:official_article).permit(:title, :content, :author, :source, :article_category_id, :status)
  end
end
