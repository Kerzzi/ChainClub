module GroupsHelper
  def render_group_description(group)
    simple_format(group.description)
  end

  def render_highlight_content(group,query_string)
    excerpt_cont = excerpt(group.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end
    
end
