class OfficialArticle < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  
  has_many :article_comments
end
