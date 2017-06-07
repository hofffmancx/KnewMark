class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "你不是管理员"
    end
  end

  private
  def not_authenticated
    redirect_to new_session_path, :alert => "请先登录"
  end

  def require_login
    respond_to do |format|
      format.html{
    unless logged_in?
      session[:return_to_url] = request.url if Config.save_return_to_url && request.get? && !request.xhr?
      send(Config.not_authenticated_action)
    end}
      format.js {
        unless logged_in?
        render text: "window.location = '/sessions/new'"
        flash[:alert] = "请先登录再进行操作 "
        end }
    end
  end
end
