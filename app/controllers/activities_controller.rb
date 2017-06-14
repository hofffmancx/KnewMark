class ActivitiesController < ApplicationController
  def index
    @knowledge = Knowledge.find_by_friendly_id!(params[:knowledge_id])
    @activities = PublicActivity::Activity.includes(:owner, :trackable).order("created_at desc")
    # .where(:trackable_id => @knowledge)
  end
end
