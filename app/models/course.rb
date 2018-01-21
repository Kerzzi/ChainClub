class Course < ApplicationRecord
  has_paper_trail
  validates :title, presence: true

  belongs_to :user
  mount_uploader :logo, CourseLogoUploader

  #定义高亮显示功能的helper方法

  def render_highlight_content(course,query_string)

    excerpt_cont = excerpt(course.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end
  
end
