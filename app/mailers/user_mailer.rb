class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(:to => user.email,
         :subject => "Your password has been reset")
  end

  def notify_welcome_info(user)
    @user = user
    mail(to: @user.email, subject: "您提交的内容已经上线，请前往查看")

  end
end
