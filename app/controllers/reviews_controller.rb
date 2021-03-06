class ReviewsController < ApplicationController
  before_action :require_login, only: [ :new, :create, :destoy, :edit, :like ]
  before_action :find_knowledge, except: [ :show, :like, :unlike ]
  before_action :find_reivew, only: [ :edit, :update, :destroy ]

  def index
    @reviews = @knowledge.reviews.includes(:user)
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.knowledge = @knowledge
    @review.user = current_user
    if @review.save
      @review.create_activity :create, owner: current_user,:params => {:knowledge_id => @review.knowledge.friendly_id}
      Notification.create(notify_type: 'create_review', target: @review, second_target: @review.knowledge, actor: current_user, user: @review.knowledge.user)

      redirect_to knowledge_path(@knowledge), notice: "评测发布成功。"
    else
      render :new
    end
  end

  def show
    @review = Review.find_by_friendly_id!(params[:id])
    @comments = @review.comments
    @comment = Comment.new
  end

  # def rate
  #   existing_score = @knowledge.find_score(current_user)
  #   if existing_score
  #     existing_score.update( :score => params[:score] )
  #   else
  #     @knowledge.scores.create( :score => params[:score], :user => current_user )
  #   end
  #   render :json => { :average_score => @knowledge.average_score }
  # end

  def edit
  end

  def update
    if @review.update(review_params)
      @review.user = current_user
      @review.create_activity :update, owner: current_user,:params => {:knowledge_id => @review.knowledge.friendly_id}

      # @review.update_event!
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
    @review = Review.find_by_friendly_id!(params[:id])
    current_user.create_action(:like, target: @review)
    @review.create_activity :like, owner: current_user,:params => {:knowledge_id => @review.knowledge.friendly_id}
    Notification.create(notify_type: 'like_review', target: @review, second_target: @review.knowledge, actor: current_user, user: @review.user)

    # @review.like!
  end

  def unlike
    @review = Review.find_by_friendly_id!(params[:id])
    current_user.destroy_action(:like, target: @review)
    @review.create_activity :unlike, owner: current_user,:params => {:knowledge_id => @review.knowledge.friendly_id}
    Notification.create(notify_type: 'unlike_review', target: @review, second_target: @review.knowledge, actor: current_user, user: @review.user)

    # @review.unlike!
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
