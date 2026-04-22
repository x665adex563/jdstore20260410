class OrderMailer < ApplicationMailer
  default from: "service@jdstore.com"

  def notify_order_placed(order)
    @order = order
    @user = order.user
    @product_lists = @order.product_lists

    mail(
      to: @user.email,
      subject: t("order_mailer.notify_order_placed.subject")
    )
  end

  def apply_cancel(order)
    @order       = order
    @user        = order.user
    @product_lists = @order.product_lists

    mail(
      to: "admin@test.com",
      subject: t("order_mailer.apply_cancel.subject",
                        email: order.user.email,
                        token: order.token)
      )
  end
end
