module Account::UsersHelper
  
  # 默认头像与用户的 id 关联，使之一一对应
  def render_head_pic(user, size)
    image_tag("user#{user.id % 10}.png", size: size)
  end

  def display_avatar(user, size)
    if user.avatar.present?
      image_tag(user.avatar.thumb.url, size: size)
    else
      render_head_pic(user, size)
    end
  end
end
