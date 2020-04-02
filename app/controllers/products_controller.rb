class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end
end
