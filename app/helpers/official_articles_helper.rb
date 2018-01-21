module OfficialArticlesHelper
  #定义高亮显示功能的helper方法

  def render_highlight_content(official_article,query_string)

    excerpt_cont = excerpt(official_article.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end
end
