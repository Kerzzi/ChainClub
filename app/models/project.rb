class Project < ApplicationRecord
  has_paper_trail
  validates :title, presence: true
  validates :website, presence: true
  validates :whitepaper, presence: true

  belongs_to :user
  has_one :project_grade
  accepts_nested_attributes_for :project_grade
  
  mount_uploader :logo, ProjectLogoUploader
  
  #定义高亮显示功能的helper方法

  def render_highlight_content(project,query_string)

    excerpt_cont = excerpt(project.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end
  
end
