class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: { message: I18n.t("cart_items.errors.blank") }
  validates :quantity, numericality: { greater_than: 0, message: I18n.t("cart_items.errors.greater_than_zero") }

  validate :check_stock

  def check_stock
    return unless quantity && product

    if quantity > product.quantity
      errors.add(:quantity, t("cart_items.errors.exceed_stock"))
    end
  end
end
