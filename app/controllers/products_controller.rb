class ProductsController < ApplicationController
  
  before_action :set_edit_product, only: [:edit, :update, :destroy]
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
    @product = Product.find(params[:id])
    @images = @product.images
    @image = @images.first
  end

  def destroy
    @product.destroy
  end

  def edit
    @images = @product.images
  end

  def update
    @product.update(product_params)
    if @product.save
      redirect_to product_path, notice: "内容を変更しました"
    else
      redirect_to edit_product_path, alert: "変更できません。入力必須項目を確認してください"
    end
  end

  def search
    @products = Product.search(params[:keyword])
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
        images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
    end

    def set_edit_product
      product = Product.where(user_id: current_user.id)
      @product = product.find(params[:id])
    end

    def set_category_parents
      @category_parents = Category.where(ancestry: nil)
    end

end
