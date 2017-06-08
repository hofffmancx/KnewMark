class UsersController < ApplicationController
  def new
    @is_using_email = true
    @user = User.new
  end

  def create
    @is_using_email = (params[:user] and !params[:user][:email].nil?)

    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "注册成功，请登录"
      redirect_to new_session_path
    else
      render action: :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation,  :cellphone, :token)
  end
end
