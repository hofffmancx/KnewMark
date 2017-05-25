class ReviewsController < ApplicationController
  before_action :require_login, only: [ :new, :create, :destoy, :edit ]
  before_action :find_knowledge
  before_action :find_reivew, only: [ :edit, :update, :destroy ]

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

  protected

  def find_knowledge
    @knowledge = Knowledge.find(params[:knowledge_id])
  end

  def find_reivew
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :content)
  end

end
