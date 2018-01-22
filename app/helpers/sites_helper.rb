module SitesHelper
  #定义高亮显示功能的helper方法

  def render_site_highlight_content(site,query_string)

    excerpt_cont = excerpt(site.name, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end  
end
