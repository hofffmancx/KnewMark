class ReviewsController < ApplicationController
  before_action :require_login, only: [ :new, :create, :destoy, :edit, :like ]
  before_action :find_knowledge, except: [ :show, :like, :unlike ]
  before_action :find_reivew, only: [ :edit, :update, :destroy ]

  def index
    @reviews = @knowledge.reviews
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.knowledge = @knowledge
    @review.user = current_user
    if @review.save
      redirect_to knowledge_path(@knowledge), notice: "评测发布成功。"
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    @comments = @review.comments
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to knowledge_path(@knowledge), notice: "评测更新成功。"
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to knowledge_path(@knowledge), alert: "评测已经删除。"
  end

  def like
    @review = Review.find(params[:id])
    current_user.create_action(:like, target: @review)
  end

  def unlike
    @review = Review.find(params[:id])
    current_user.destroy_action(:like, target: @review)
  end

  protected

  def find_knowledge
    @knowledge = Knowledge.find_by_friendly_id!(params[:knowledge_id])
  end

  def find_reivew
    @review = current_user.reviews.find_by_friendly_id!(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :content)
  end

end
