class OrderMailer < ApplicationMailer
  default from: "JD Store no-reply@jdstoreapp.com"

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
      to: ENV.fetch("ADMIN_EMAIL", "x665adex563@gmail.com"),
      subject: t("order_mailer.apply_cancel.subject",
                        email: order.user.email,
                        token: order.token)
      )
  end

  def notify_ship(order)
    @order        = order
    @user         = order.user
    @product_lists = @order.product_lists

    mail(
      to: @user.email,
      subject: t("order_mailer.notify_ship.subject", token: order.token)
    )
  end

  def notify_cancel(order)
    @order        = order
    @user         = order.user
    @product_lists = @order.product_lists

    mail(
      to: @user.email,
      subject: t("order_mailer.notify_cancel.subject", token: order.token)
    )
  end
end
