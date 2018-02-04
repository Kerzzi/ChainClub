class PostComment < ApplicationRecord
  validates :content, presence: true
  
  belongs_to :user
  belongs_to :post
  
  scope :recent, -> { order("created_at DESC")}
  
end
