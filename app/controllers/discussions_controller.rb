class DiscussionsController < ApplicationController
  before_action :require_login, only: [ :new, :create, :destoy, :edit, :like, :unlike ]
  before_action :find_knowledge, except: [ :like, :unlike ]
  before_action :find_reivew, only: [ :edit, :update, :destroy ]

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.knowledge = @knowledge
    @discussion.user = current_user
    if @discussion.save
      redirect_to knowledge_path(@knowledge), notice: "评测发布成功。"
    else
      render :new
    end
  end

  def show
    @discussion = Discussion.find(params[:id])
  end

  def edit
  end

  def update
    if @discussion.update(discussion_params)
      redirect_to knowledge_path(@knowledge), notice: "评测更新成功。"
    else
      render :edit
    end
  end

  def destroy
    @discussion.destroy
    redirect_to knowledge_path(@knowledge), alert: "评测已经删除。"
  end

  def like
    @discussion = Discussion.find(params[:id])
    current_user.create_action(:like, target: @discussion)
  end

  def unlike
    @discussion = Discussion.find(params[:id])
    current_user.destroy_action(:like, target: @discussion)
  end

  protected

  def find_knowledge
    @knowledge = Knowledge.find(params[:knowledge_id])
  end

  def find_reivew
    @discussion = current_user.discussions.find(params[:id])
  end

  def discussion_params
    params.require(:discussion).permit(:content)
  end


end
