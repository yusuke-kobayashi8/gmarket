class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new
    if @producut.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

    def product_params
      params.require(:product).permit(:name, :price, :detail, :status, :derivery_fee, :derivery_days, :place, :category_id, :brand_id).merge(user_id: current_user.id)
    end
end
