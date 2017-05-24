class KnowledgesController < ApplicationController
  before_action :require_login, :only => [:new, :create, :like, :unlike, :star, :unstar, :follow, :unfollow]

  def index
    @knowledges = Knowledge.where(:status => "published").recent
  end

  def show
    @knowledge = Knowledge.find(params[:id])
    unless @knowledge.status == "published"
      flash[:warning] = "此课程未上线"
      redirect_to knowledges_path
    end
  end

  def new
    @knowledge = Knowledge.new
  end

  def create
    @knowledge = Knowledge.new(knowledge_params)

    if @knowledge.save
      flash[:notice] = "产品已提交，待审核中..."
      redirect_to knowledges_path
    else
      render :new
    end
  end

  def rate
    @knowledge = Knowledge.find(params[:id])
    existing_score = @knowledge.find_score(current_user)
    if existing_score
      existing_score.update( :score => params[:score] )
    else
      @knowledge.scores.create( :score => params[:score], :user => current_user )
    end
    render :json => { :average_score => @knowledge.average_score }
  end

  def like
    @knowledge = Knowledge.find(params[:id])
    current_user.create_action(:like, target: @knowledge)
    redirect_to knowledge_path(@knowledge)
  end

  def unlike
    @knowledge = Knowledge.find(params[:id])
    current_user.destroy_action(:like, target: @knowledge)
    redirect_to knowledge_path(@knowledge)
  end

  def star
    @knowledge = Knowledge.find(params[:id])
    current_user.create_action(:star, target: @knowledge)
    redirect_to knowledge_path(@knowledge)
  end

  def unstar
    @knowledge = Knowledge.find(params[:id])
    current_user.destroy_action(:star, target: @knowledge)
    redirect_to knowledge_path(@knowledge)
  end

  def follow
    @knowledge = Knowledge.find(params[:id])
    current_user.create_action(:follow, target: @knowledge)
    redirect_to knowledge_path(@knowledge)
  end

  def unfollow
    @knowledge = Knowledge.find(params[:id])
    current_user.destroy_action(:follow, target: @knowledge)
    redirect_to knowledge_path(@knowledge)
  end

  private

  def knowledge_params
    params.require(:knowledge).permit(:title, :subtitle, :description, :appropriate, :notice, :photos_attributes => [:id, :image, :_destroy])
  end
end
