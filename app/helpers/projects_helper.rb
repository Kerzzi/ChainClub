module ProjectsHelper
  #定义高亮显示功能的helper方法

  def render_highlight_content(project,query_string)

    excerpt_cont = excerpt(project.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end  
end
