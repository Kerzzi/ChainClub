class ProjectGrade < ApplicationRecord
  has_paper_trail
  belongs_to :project
end
