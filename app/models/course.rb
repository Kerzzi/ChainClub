class Course < ApplicationRecord
  has_paper_trail
  validates :title, presence: true

  belongs_to :user
  mount_uploader :logo, CourseLogoUploader


  
end
