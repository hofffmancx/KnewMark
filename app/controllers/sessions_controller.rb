class SessionsController < ApplicationController

  def new
  end

  def create
    if user = login(params[:email], params[:password], params[:remember])
      flash[:notice] = "登录成功"
       redirect_back_or_to root_url, :notice => "登陆成功！"
    else
      flash[:alert] = "邮箱或密码不正确"
      redirect_to new_session_path
    end
  end

  def destroy
    logout
    flash[:notice] = "退出成功"
    redirect_to root_path
  end
end
