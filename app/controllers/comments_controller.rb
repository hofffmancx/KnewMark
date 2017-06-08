class CommentsController < ApplicationController
  before_action :find_comment, only: [ :edit, :update, :destroy ]
  before_action :find_reivew, only: [ :create, :edit, :update, :destroy ]

  def create
    @comment = Comment.new(comment_params)
    @comment.review = @review
    @comment.user = current_user
    @comment.save
  end

  def edit
  end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  def like
    @comment = Comment.find_by_friendly_id(params[:id])
    current_user.create_action(:like, target: @comment)
  end

  def unlike
    @comment = Comment.find_by_friendly_id(params[:id])
    current_user.destroy_action(:like, target: @comment)
  end

  protected

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_comment
    @comment = current_user.comments.find_by_friendly_id!(params[:id])
  end

  def find_reivew
    @review = Review.find_by_friendly_id!(params[:review_id])
  end

end
