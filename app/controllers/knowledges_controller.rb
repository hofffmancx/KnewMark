class KnowledgesController < ApplicationController
  before_action :require_login, :only => [:new, :create]

  def index
    @knowledges = Knowledge.where(:status => "published").recent
  end

  def show
    @knowledge = Knowledge.find(params[:id])
    if !@knowledge.published?
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

  private

  def knowledge_params
    params.require(:knowledge).permit(:title, :subtitle, :description, :appropriate, :notice, :photos_attributes => [:id, :image, :_destroy])
  end
end
