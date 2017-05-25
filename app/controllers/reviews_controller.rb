class ReviewsController < ApplicationController
  before_action :find_knowledge
  before_action :require_login, only: [ :new, :create, :destoy, :edit ]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to knowledge_path(@knowledge), notice: "评测发布成功。"
    end
  end

  protected

  def find_knowledge
    @knowledge = Knowledge.find(params[:knowledge_id])
  end

  def review_params
    params.require(:review).permit(:title, :content)
  end

end
