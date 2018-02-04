class Course < ApplicationRecord
  has_paper_trail
  validates :title, presence: true

  belongs_to :user
  has_many :course_comments, dependent: :destroy

  has_many :course_relationships
  has_many :favors, through: :course_relationships, source: :user  
  
  mount_uploader :logo, CourseLogoUploader
  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS
  
  
  # Scope #
  scope :published, -> { where(:status => "public")}
  scope :recent, -> { order("created_at DESC")}
  
end
