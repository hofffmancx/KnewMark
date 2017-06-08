module Account::UsersHelper
  def render_head_pic
    rand_num = rand(5) + 1
    image_tag("user#{rand_num}.jpg", size:"150x150")
  end
end
