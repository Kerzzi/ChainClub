class OfficialArticle < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  
  has_many :article_comments, dependent: :destroy
  belongs_to :article_category, :optional => true
end
