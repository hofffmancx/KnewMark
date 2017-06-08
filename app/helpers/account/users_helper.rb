module Account::UsersHelper
  def render_head_pic(size)
    rand_num = rand(5) + 1
    image_tag("user#{rand_num}.jpg", size: size)
  end

  def display_avatar(user, size)
    if user.avatar.present?
      image_tag(user.avatar.thumb.url, size: size)
    else
      render_head_pic(size)
    end
  end
end
