class Admin::KnowledgesController < AdminController
  before_action :validate_search_key, only: [:search]
  before_action :find_knowledge, except: [:index, :new, :create, :search ]

  def index
    @knowledges = case params[:status]
                  when "by_published"
                    Knowledge.where(:status => "published").all
                  when "by_failed"
                    Knowledge.where(:status => "failed").all
                  when "by_hidden"
                    Knowledge.where(:status => "hidden").all
                  else
                    Knowledge.all.recent
                  end
    @knowledges = @knowledges.includes(:photos)
  end

  def show
  end

  def new
    @knowledge = Knowledge.new
    @root_categories = Category.roots
  end

  def edit
    @root_categories = Category.roots
  end

  def create
    @knowledge = Knowledge.new(knowledge_params)
    @root_categories = Category.roots
    @knowledge.user = current_user
    if @knowledge.save
      redirect_to admin_knowledges_path
    else
      render :new
    end
  end

  def update
    @root_categories = Category.roots
    @knowledge.user = current_user
    if @knowledge.update(knowledge_params)
      flash[:notice] = "更新成功"
      redirect_to admin_knowledges_path
    else
      render :edit
    end
  end

  def destroy
    @knowledge.destroy
    flash[:alert] = "已删除"
    redirect_to admin_knowledges_path
  end

  def hide
    @knowledge.reject!
    flash[:alert] = "产品已下线"
    redirect_to :back
  end

  def reject
    @knowledge.reject!
    KnowledgeMailer.notify_knowledge_rejected(@knowledge).deliver_later
    flash[:alert] = "产品驳回，已通知重新修改"
    redirect_to :back
  end

  def publish
    @knowledge.publish!
    KnowledgeMailer.notify_knowledge_passed(@knowledge).deliver_later
    flash[:notice] = "产品已上线"
    redirect_to :back
  end

  def search
    if @query_string.present?
      @knowledges = search_params
    end
  end

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
  end

  def search_params
    Knowledge.ransack({:title_or_subtitle_or_description_cont => @query_string}).result(distinct: true)
  end

  private

  def find_knowledge
    @knowledge = Knowledge.find_by_friendly_id!(params[:id])
  end

  def knowledge_params
    params.require(:knowledge).permit(:title, :subtitle, :description, :appropriate, :notice, :category_id, :tags_string, :photos_attributes => [:id, :image, :_destroy])
  end
end
