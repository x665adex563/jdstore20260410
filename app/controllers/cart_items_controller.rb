class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    current_cart.add_product(product)

    redirect_back fallback_location: root_path,
                  notice: t("cart_items.flash.added")
  end

  def destroy
    @cart_item = current_cart.cart_items.find(params[:id])
    @product = @cart_item.product
    @cart_item.destroy
    flash[:notice] = t("cart_items.destroyed_notice", product:@product.title)
    redirect_back(fallback_location: carts_path)
  end
end
