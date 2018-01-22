module ApplicationHelper
  def avatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm"
  end
  
  def render_user_avatar(user, size)
    if user.avatar.present?
      user.avatar
    else
      avatar_url(user, size)
    end
  end


  #定义高亮显示功能的helper方法，所有model公用，目前除site外，均只搜索title，site搜索的是name,后期修改字段

  def render_highlight_content(modle_name,query_string)

    excerpt_cont = excerpt(modle_name.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end  

end
