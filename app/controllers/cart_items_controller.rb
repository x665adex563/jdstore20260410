class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    current_cart.add_product(product)

    redirect_back fallback_location: root_path,
                  notice: t("cart_items.flash.added")
  end
end
