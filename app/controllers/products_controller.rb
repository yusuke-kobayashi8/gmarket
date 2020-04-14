class ProductsController < ApplicationController
  def index
    @products = Product.includes(:images).order('created_at DESC')
    @parents = Category.all.order("id ASC").limit(13)
    @category_parent = Category.where(ancestry: nil)
  end

  def new
    @product = Product.new
    @product.images.new
    @category_parents = []
    Category.where(ancestry: nil).each do |parent|
      @category_parents << parent
    end
  end

  def category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def category_grandchildren
    
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @images = @product.images
    @image = @images.first
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
  end

  def edit
    @product = Product.find(params[:id])
  end


  private

    def product_params
      params.require(:product).permit(
        :name,
        :price,
        :detail,
        :status_id,
        :delivery_cost_id,
        :days_to_ship_id,
        :prefecture_id,
        :category_id,
        :brand_id,
        images_attributes: [:image]).merge(user_id: current_user.id)
    end
end
