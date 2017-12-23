class OfficialArticle < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  
  has_many :artile_comments
end
