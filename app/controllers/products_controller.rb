class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :set_category_parents, only: [:new, :create, :edit, :update]

  def index
    @products = Product.includes(:images).order('created_at DESC')
    @product_unsold = Product.includes(:images).where(purchaser_id: nil).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new
    @images = @product.images
  end

  def category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: "出品しました"
    else
      redirect_to new_product_path, alert: "出品できません。入力必須項目を確認してください"
    end
  end

  def show
    @images = @product.images
    @image = @images.first
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
  end

  def edit
    product = Product.where(user_id: current_user.id)
    @product = product.find(params[:id])
    @images = @product.images
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_update_params)
    if @product.save
      redirect_to product_path, notice: "内容を変更しました"
    else
      redirect_to edit_product_path, alert: "変更できません。入力必須項目を確認してください"
    end
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

    def product_update_params
      params.require(:product).permit(
        :name,
        [images_attributes: [:image, :_destroy, :id]])
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def set_category_parents
      @category_parents = Category.where(ancestry: nil)
    end
end
