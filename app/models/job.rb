class Job < ApplicationRecord
  has_paper_trail
  validates :title, presence: true
  validates :publisher, presence: true

  belongs_to :user

  CATEGORYS = ["fulltime", "internship"]

end
