class CategoryController < ApplicationController
  def index
    @parents = Category.all.order("id ASC").limit(13)
    @category_parent = Category.where(ancestry: nil)
    @categories = Category.eager_load(children: :children).where(parent_id: nil) 
  end

  def show
    @category = Category.find(params[:id])
    @products = Product.where(category_id: @category.id).order("created_at DESC")
  end

end