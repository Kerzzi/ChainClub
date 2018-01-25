class Project < ApplicationRecord
  has_paper_trail
  validates :title, presence: true
  validates :website, presence: true
  validates :whitepaper, presence: true

  belongs_to :user
  has_one :project_grade
  accepts_nested_attributes_for :project_grade
  
  mount_uploader :logo, ProjectLogoUploader
  
  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS

  # Scope #
  scope :published, -> { where(:status => "public")}
  scope :recent, -> { order("created_at DESC")}
end
