class Post < ApplicationRecord
  has_paper_trail
  validates :title, presence: true
  validates :content, presence: true
    
  belongs_to :user
  belongs_to :group
  has_many :post_comments, dependent: :destroy
  has_many :post_relationships
  has_many :favors, through: :post_relationships, source: :user    

  scope :recent, -> { order("created_at DESC")}
  scope :random5, -> { limit(5).order("RANDOM()") }
  
end
