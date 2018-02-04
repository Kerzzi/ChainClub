class ArticleCategory < ApplicationRecord
  has_many :official_articles
  has_paper_trail
  
  scope :recent, -> { order("created_at DESC")}
end
