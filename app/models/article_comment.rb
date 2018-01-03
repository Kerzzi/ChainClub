class ArticleComment < ApplicationRecord
  has_paper_trail
  
  belongs_to :user
  belongs_to :official_article
  
  validates :content, presence: true
end
