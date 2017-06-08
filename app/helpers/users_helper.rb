module UsersHelper
  def render_status(user, status)
    if user == current_user
      content_tag(:h4, "我#{status}")
    else
      content_tag(:h4, "他/她#{status}")
    end
  end
end
