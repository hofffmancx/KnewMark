class CategoriesController < ApplicationController
  def show
    @categories = Category.grouped_data
    @category = Category.find(params[:id])
  end

end
