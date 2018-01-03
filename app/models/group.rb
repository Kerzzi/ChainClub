class Group < ApplicationRecord
  has_paper_trail
  validates :title, presence: true
  validates :description, presence: true
  
  belongs_to :user
  has_many :posts
  
end
