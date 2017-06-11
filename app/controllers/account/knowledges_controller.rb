class Account::KnowledgesController < ApplicationController
  before_action :require_login
  
  def index
    @knowledges = current_user.knowledges.recent
  end
end
