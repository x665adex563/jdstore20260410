class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])

    if current_cart.add_product(product)
      redirect_back fallback_location: root_path, notice: t("cart_items.flash.added")
    else
      redirect_back fallback_location: root_path, alert: t("cart_items.flash.out_of_stock")
    end
  end

  def destroy
    @cart_item = current_cart.cart_items.find(params[:id])
    @product = @cart_item.product
    @cart_item.destroy
    flash[:notice] = t("cart_items.destroyed_notice", product:@product.title)
    redirect_back(fallback_location: carts_path)
  end

  def update
    @cart_item = current_cart.cart_items.find(params[:id])

    if @cart_item.product.quantity >= cart_item_params[:quantity].to_i
      if @cart_item.update(cart_item_params)
        flash[:notice] = t("cart_items.updated_notice")
      else
        flash[:alert] = @cart_item.errors.full_messages.join(", ")
      end
    else
      flash[:alert] = t("cart_items.flash.out_of_stock")
    end

    redirect_to carts_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
