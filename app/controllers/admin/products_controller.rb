class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: t("admin.products.flash.created")
    else
      render :new
    end
  end

  def index
    @products = Product.all
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_product_path, notice: t("admin.products.flash.updated")
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: t("admin.products.flash.deleted")
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
