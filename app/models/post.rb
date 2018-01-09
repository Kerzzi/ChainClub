class Post < ApplicationRecord
  has_paper_trail
  validates :title, presence: true
  validates :content, presence: true
    
  belongs_to :user
  belongs_to :group

  scope :recent, -> { order("created_at DESC")}
  
  
end
