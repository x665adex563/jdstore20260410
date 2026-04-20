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
end
