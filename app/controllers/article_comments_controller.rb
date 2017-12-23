class ArticleCommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :destroy]

  def new
    @official_article = OfficialArticle.find(params[:official_article_id])
    @article_comment = ArticleComment.new
  end

  def create
    @official_article = OfficialArticle.find(params[:official_article_id])
    @article_comment = ArticleComment.new(article_comment_params)
    @article_comment.official_article = @official_article
    @article_comment.user = current_user

    if @article_comment.save
      redirect_to official_article_path(@official_article)
    else
      render :new
    end
  end

  def destroy
    @official_article = OfficialArticle.find(params[:official_article_id]) 
    @article_comment = ArticleComment.find(params[:id]) 
    
    if current_user != @article_comment.user
      redirect_to official_article_path(@official_article), alert: "抱歉，您没有相应的权限！"
    end
    
    @article_comment.destroy
    redirect_to official_article_path(@official_article), alert: "删除成功！"
  end
  
  private

  def article_comment_params
    params.require(:article_comment).permit(:content)
  end
end
