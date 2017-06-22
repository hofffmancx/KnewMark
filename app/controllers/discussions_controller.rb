class DiscussionsController < ApplicationController
  before_action :require_login, only: [ :new, :create, :destoy, :edit, :like, :unlike ]
  before_action :find_knowledge, except: [ :like, :unlike ]
  before_action :find_reivew, only: [ :edit, :update, :destroy ]

  def index
    @discussions = @knowledge.discussions.includes(:user)
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.knowledge = @knowledge
    @discussion.user = current_user
    if @discussion.save
      @discussion.create_activity :create, owner: current_user,:params => {:knowledge_id => @discussion.knowledge.friendly_id}
      redirect_to knowledge_path(@knowledge), notice: "评测发布成功。"
    else
      render :new
    end
  end

  def show
    @discussion = Discussion.find_by_friendly_id!(params[:id])
  end

  def edit
  end

  def update
    if @discussion.update(discussion_params)
      @discussion.user = current_user
      @discussion.create_activity :update, owner: current_user,:params => {:knowledge_id => @discussion.knowledge.friendly_id}
      # @discussion.update_event!
      redirect_to knowledge_path(@knowledge), notice: "评测更新成功。"
    else
      render :edit
    end
  end

  def destroy
    @discussion.destroy
    @discussion.user = current_user
    @discussion.create_activity :destroy, owner: current_user,:params => {:knowledge_id => @discussion.knowledge.friendly_id}
    redirect_to knowledge_path(@knowledge), alert: "评测已经删除。"
  end

  def like
    @discussion = Discussion.find_by_friendly_id!(params[:id])
    current_user.create_action(:like, target: @discussion)
    @discussion.user = current_user
    @discussion.create_activity :like, owner: current_user,:params => {:knowledge_id => @discussion.knowledge.friendly_id}
    Notification.create(notify_type: 'like_discussion', target: @discussion, second_target: @discussion.knowledge, actor: current_user, user: @discussion.user)
    # @discussion.like!
  end

  def unlike
    @discussion = Discussion.find_by_friendly_id!(params[:id])
    current_user.destroy_action(:like, target: @discussion)
    @discussion.user = current_user
    @discussion.create_activity :unlike, owner: current_user,:params => {:knowledge_id => @discussion.knowledge.friendly_id}
    Notification.create(notify_type: 'unlike_discussion', target: @discussion, second_target: @discussion.knowledge, actor: current_user, user: @discussion.user)

    # @discussion.unlike!
  end

  protected

  def find_knowledge
    @knowledge = Knowledge.find_by_friendly_id!(params[:knowledge_id])
  end

  def find_reivew
    @discussion = current_user.discussions.find_by_friendly_id!(params[:id])
  end

  def discussion_params
    params.require(:discussion).permit(:content)
  end


end
