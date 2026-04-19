class OrderMailer < ApplicationMailer
  default from: "service@jdstore.com"

  def notify_order_placed(order)
    @order       = order
    @user        = order.user
    @product_lists = @order.product_lists
﻿
    mail(to: @user.email , subject: t("order_mailer.notify_order_placed.subject"))
  end
end
