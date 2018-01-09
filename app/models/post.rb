class Post < ApplicationRecord
  has_paper_trail
  validates :title, presence: true
  validates :content, presence: true
    
  belongs_to :user
  belongs_to :group
  has_many :post_comments, dependent: :destroy

  scope :recent, -> { order("created_at DESC")}
  
  
end
