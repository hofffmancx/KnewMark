class PostsController < ApplicationController
  def index
    @activities = PublicActivity::Activity.includes(:owner, :trackable).order("created_at desc")
  end
end
