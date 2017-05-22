class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def not_authenticated
    redirect_to new_session_path, :alert => "请先登录"
  end
end
