class Job < ApplicationRecord
  has_paper_trail
  validates :title, presence: true
  validates :publisher, presence: true

  belongs_to :user

  CATEGORYS = ["fulltime", "internship"]

  # Scope #
  scope :recent, -> { order("created_at DESC")}
  scope :deadline, -> { order("deadline DESC")}
  scope :published, -> { where(:is_hidden => false)}
  scope :internship_job, -> { where(:category => "internship")}
  scope :fulltime_job, -> { where(:category => "fulltime")}
  scope :random5, -> { limit(5).order("RANDOM()") }

end
