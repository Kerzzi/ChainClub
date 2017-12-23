class ArticleComment < ApplicationRecord
  belongs_to :user
  belongs_to :official_article
  
  validates :content, presence: true
end
