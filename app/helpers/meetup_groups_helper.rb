module MeetupGroupsHelper
  #定义高亮显示功能的helper方法

  def render_highlight_content(meetup_group,query_string)

    excerpt_cont = excerpt(meetup_group.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end  
end
