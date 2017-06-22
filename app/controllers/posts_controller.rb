class PostsController < ApplicationController
  def index
    @activities = PublicActivity::Activity.includes(:owner, :trackable)
    @activities = @activities.where({trackable_type: ["Review", "Question"]} ).order("id desc")
  end
end
