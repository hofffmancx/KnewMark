class Account::UsersController < ApplicationController

  before_action :require_login, except: [:update]

  def edit
    @user = current_user
    @user.create_profile unless @user.profile
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = "修改成功"
      redirect_to edit_account_user_path
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:username, :avatar, :remove_avatar, :profile_attributes => [:id, :gender, :birthday, :location, :website, :self_introduction ])
  end

end
