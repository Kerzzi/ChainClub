module CoursesHelper
  #定义高亮显示功能的helper方法

  def render_highlight_content(course,query_string)

    excerpt_cont = excerpt(course.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end  
end
