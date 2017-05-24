class KnowledgesController < ApplicationController
  before_action :require_login, :only => [:new, :create, :add, :remove]
  before_action :validate_search_key, only: [:search]

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

  def search
    if @query_string.present?
      @knowledges = search_params
      @knowledges = @knowledges.where(:status => "published")
    end
  end

  def add
    @knowledge = Knowledge.find(params[:id])
    if !current_user.is_liker_of?(@knowledge)
      current_user.add!(@knowledge)
      flash[:notice] = "已将课程加入心愿单！"
    end
    redirect_to :back
  end

  private

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
  end

  def search_params
    Knowledge.ransack({:title_or_subtitle_or_description_cont => @query_string}).result(distinct: true)
  end

  def knowledge_params
    params.require(:knowledge).permit(:title, :subtitle, :description, :appropriate, :notice, :photos_attributes => [:id, :image, :_destroy])
  end
end
