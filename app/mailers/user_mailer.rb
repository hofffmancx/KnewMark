class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = User.find user.id
    mail(:to => user.email,
         :subject => "您要求修改密码")
  end

  def notify_welcome_info(user)
    @user = user
    mail(to: @user.email, subject: "您提交的内容已经上线，请前往查看")

  end
end
