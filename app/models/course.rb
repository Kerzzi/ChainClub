class Course < ApplicationRecord
  has_paper_trail
  validates :title, presence: true
  
  belongs_to :user
end
