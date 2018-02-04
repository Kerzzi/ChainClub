class ArticleComment < ApplicationRecord
  has_paper_trail
  
  belongs_to :user
  belongs_to :official_article
  
  validates :content, presence: true
  
  scope :recent, -> { order("created_at DESC")}
end
