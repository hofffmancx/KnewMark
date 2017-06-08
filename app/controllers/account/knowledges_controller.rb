class Account::KnowledgesController < ApplicationController
  before_action :require_login

  def index
    @knowledges = current_user.wishlists.recent
  end

  def remove
    @knowledge = Knowledge.find_by_friendly_id(params[:id])
    if current_user.is_liker_of?(@knowledge)
      current_user.remove!(@knowledge)
      flash[:notice] = "已将课程移出心愿单！"
    end
    redirect_to :back
  end
end
