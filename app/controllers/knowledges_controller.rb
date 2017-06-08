class KnowledgesController < ApplicationController
  before_action :require_login, except: [ :index, :show ]
  before_action :validate_search_key, only: [:search]

  def index
    @knowledges = Knowledge.includes(:photos).where(:status => "published")

    @knowledges = @knowledges.limit(20)

    if params[:category].present?
      @category = params[:category]
      @category_id = Category.find_by(title: params[:category]).id
      @knowledges = @knowledges.where(category_id: @category_id)
    end

    if params[:order].present?
      @knowledges = case params[:order]
      when "by_have_counts"
        @knowledges.order("haves_count DESC")
      when "by_want_counts"
        @knowledges.order("wants_count DESC")
      when "by_follows_counts"
        @knowledges.order("follows_count DESC")
      when "by_likes_counts"
        @knowledges.order("likes_count DESC")
      end
    end

    @knowledges = @knowledges.recent

    if params[:max_id]
      @knowledges = @knowledges.where( "id < ?", params[:max_id])
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @knowledge = Knowledge.find(params[:id])
    unless @knowledge.status == "published"
      flash[:warning] = "此课程未上线"
      redirect_to knowledges_path
    end
    @reviews = @knowledge.reviews.recent.limit(3)
    @discussions = @knowledge.discussions.recent.limit(3)
    @questions = @knowledge.questions.recent.limit(3)
  end

  def new
    @knowledge = Knowledge.new
    @root_categories = Category.roots
  end

  def create
    @knowledge = Knowledge.new(knowledge_params)
    @root_categories = Category.roots
    @knowledge.user = current_user
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
  end

  def unlike
    @knowledge = Knowledge.find(params[:id])
    current_user.destroy_action(:like, target: @knowledge)
  end

  def star
    @knowledge = Knowledge.find(params[:id])
    current_user.create_action(:star, target: @knowledge)
  end

  def unstar
    @knowledge = Knowledge.find(params[:id])
    current_user.destroy_action(:star, target: @knowledge)
  end

  def follow
    @knowledge = Knowledge.find(params[:id])
    current_user.create_action(:follow, target: @knowledge)
  end

  def unfollow
    @knowledge = Knowledge.find(params[:id])
    current_user.destroy_action(:follow, target: @knowledge)
  end

  def search
    if @query_string.present?
      @knowledges = search_params
      @knowledges = @knowledges.where(:status => "published")
    end
  end

  def want
    @knowledge = Knowledge.find(params[:id])
    current_user.destroy_action(:have, target: @knowledge)
    current_user.create_action(:want, target: @knowledge)
  end

  def unwant
    @knowledge = Knowledge.find(params[:id])
    current_user.destroy_action(:want, target: @knowledge)
  end

  def have
    @knowledge = Knowledge.find(params[:id])
    current_user.destroy_action(:want, target: @knowledge)
    current_user.create_action(:have, target: @knowledge)
  end

  def unhave
    @knowledge = Knowledge.find(params[:id])
    current_user.destroy_action(:have, target: @knowledge)
  end

  private

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
  end

  def search_params
    Knowledge.ransack({:title_or_subtitle_or_description_cont => @query_string}).result(distinct: true)
  end

  def knowledge_params
    params.require(:knowledge).permit(:title, :subtitle, :description, :appropriate, :notice, :category_id, :tags_string, :photos_attributes => [:id, :image, :_destroy])
  end
end
