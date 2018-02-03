class CourseComment < ApplicationRecord
  belongs_to :course
  belongs_to :user
  
  validates :content, presence: true
  
  scope :recent, -> { order("created_at DESC")}
end
