class CategoriesController < ApplicationController

  def index
    @categories = Category.grouped_data
    @knowledges = Knowledge.where(:status => "published").recent.page(params[:page] || 1).per_page(params[:per_page] || 12)
  end

  def show
    @categories = Category.grouped_data
    @category = Category.find(params[:id])
    @knowledges = @category.knowledges.where(:status => "published").page(params[:page] || 1).per_page(params[:per_page] || 12)
  .recent
  end

end
