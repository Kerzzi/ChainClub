module GroupsHelper
  def render_group_description(group)
    simple_format(group.description)
  end
end
