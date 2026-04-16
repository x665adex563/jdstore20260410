class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items, source: :product

  def add_product(product)
    return false if product.quantity <= 0

    item = cart_items.find_or_initialize_by(product_id: product.id)
    item.quantity ||= 0
    item.quantity += 1
    item.save
  end
end
