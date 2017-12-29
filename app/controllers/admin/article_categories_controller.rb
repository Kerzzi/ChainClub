class Admin::ArticleCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @article_categories = ArticleCategory.all
  end  

  def edit
    @article_category = ArticleCategory.find(params[:id])
  end  
  
  def new
    @article_category = ArticleCategory.new
  end

  def create
    @article_category = ArticleCategory.new(article_category_params)
    
    if @article_category.save
      redirect_to admin_article_categories_path
    else
      render :new
    end 
  end
  
  def update 
    @article_category = ArticleCategory.find(params[:id])
      
    if @article_category.update(article_category_params)
      redirect_to admin_article_categories_path, notice:"更新成功！"
    else
      render :edit 
    end
  end
  
  def destroy  
    @article_category = ArticleCategory.find(params[:id])
    @article_category.destroy
    redirect_to admin_article_categories_path, alert: "删除成功！"
  end

  private
 
  def article_category_params
    params.require(:article_category).permit(:name)
  end 
end
