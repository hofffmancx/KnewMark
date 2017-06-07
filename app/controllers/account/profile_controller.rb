class Account::ProfileController < ApplicationController
  before_action :require_login
  def password
  end

  def update_password
    if current_user.valid_password?(params[:old_password])
      current_user.password_confirmation = params[:password_confirmation]

      if current_user.change_password!(params[:password])
        flash[:notice] = "密码修改成功"
        redirect_to account_password_path
      else
        render action: :password
      end
    else
      current_user.errors.add :old_password, "旧密码不正确"
      render action: :password
    end
  end

end
