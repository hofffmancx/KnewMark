class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include PublicActivity::StoreController


  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "你不是管理员"
    end
  end


  helper_method :current_days
  # helper_method :current_owners
  def current_days
    @current_days ||= find_day
  end
  #
  # def current_owners
  #   @current_owners ||= find_owner
  # end
  private


  #
  def find_day
    days = session[:days]

    if days.blank?
      days = []
    end

    session[:days] = days

    days
  end
  #
  # def find_owner
  #   owners = session[:owners]
  #
  #   if owners.blank?
  #     owners = []
  #   end
  #
  #   session[:owners] = owners
  #
  #   owners
  # end

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
