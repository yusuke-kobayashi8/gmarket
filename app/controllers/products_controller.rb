class ProductsController < ApplicationController
  def index
    @products = Product.includes(:images).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

    def product_params
      params.require(:product).permit(:name, :price, :detail, :status_id, :delivery_cost_id, :days_to_ship_id, :prefecture_id, :category_id, :brand_id, images_attributes: [:image]).merge(user_id: current_user.id)
    end
end
