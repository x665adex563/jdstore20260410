class Admin::OrdersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @orders = Order.order(id: :desc)
  end

  def show
    @order = Order.find_by!(token: params[:id])
    @product_lists = @order.product_lists
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship!
    redirect_back(fallback_location: admin_orders_path)
  end

  def shipped
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_back(fallback_location: admin_orders_path)
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel_order!
    redirect_back(fallback_location: admin_orders_path)
  end

  def return
    @order = Order.find(params[:id])
    @order.return_good!
    redirect_back(fallback_location: admin_orders_path)
  end
end
