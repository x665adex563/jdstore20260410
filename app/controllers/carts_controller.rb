class CartsController < ApplicationController
  def clear
    current_cart.clear!
    flash[:notice] = t("carts.cleared_notice")
    redirect_to carts_path
  end
end
