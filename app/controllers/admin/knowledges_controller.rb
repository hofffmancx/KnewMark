class Admin::KnowledgesController < ApplicationController
  before_action :require_login
  before_action :require_admin
  layout "admin"

  def index
    @knowledges = case params[:status]
    when "by_hidden"
      Knowledge.where(:is_hidden => true).all
    when "by_published"
      Knowledge.where(:is_hidden => false).all
    else
      Knowledge.all.recent
    end
  end

  def show
    @knowledge = Knowledge.find(params[:id])
  end

  def new
    @knowledge = Knowledge.new
  end

  def edit
    @knowledge = Knowledge.find(params[:id])
  end

  def create
    @knowledge = Knowledge.new(knowledge_params)

    if @knowledge.save
      redirect_to admin_knowledges_path
    else
      render :new
    end
  end

  def update
    @knowledge = Knowledge.find(params[:id])

    if @knowledge.update(knowledge_params)
      flash[:notice] = "更新成功"
      redirect_to admin_knowledges_path
    else
      render :edit
    end
  end

  def destroy
    @knowledge = Knowledge.find(params[:id])
    @knowledge.destroy
    flash[:alert] = "已删除"
    redirect_to admin_knowledges_path
  end

  def hide
    @knowledge = Knowledge.find(params[:id])
    @knowledge.hide!
    flash[:notice] = "产品已下线"
    redirect_to :back
  end

  def publish
    @knowledge = Knowledge.find(params[:id])
    @knowledge.publish!
    flash[:notice] = "产品已上线"
    redirect_to :back
  end

  private

  def knowledge_params
    params.require(:knowledge).permit(:title, :subtitle, :description, :appropriate, :notice, :photos_attributes => [:id, :image, :_destroy])
  end
end
