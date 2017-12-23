class OfficialArticlesController < ApplicationController
  def index
    @official_articles = OfficialArticle.all
  end
end
