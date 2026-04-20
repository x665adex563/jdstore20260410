module Admin::OrdersHelper
  def render_order_paid_state(order)
    if order.is_paid?
      t("orders.paid")
    else
      t("orders.unpaid")
    end
  end
end
