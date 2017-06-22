class PostsController < ApplicationController
  require 'will_paginate/array'
  def index
    # @activities = PublicActivity::Activity.includes(:owner, :trackable)
    # @activities = @activities.where({trackable_type: ["Review", "Question"]} ).order("id desc")
    @posts = Review.all.includes(:user, knowledge: [:photos]) + Question.all.includes(:user, knowledge: [:photos])
    @posts = @posts.sort_by{|post| post.created_at}.reverse
    @posts = @posts.paginate(:page => params[:page], :per_page => 30)
  end
end
