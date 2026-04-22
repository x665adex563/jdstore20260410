class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items, source: :product

  def add_product(product)
    return false if product.quantity <= 0

    item = cart_items.find_or_initialize_by(product_id: product.id)
    if item.new_record?
      item.quantity = 1
    else
      item.quantity += 1
    end
    item.save
  end

  def total_price
    sum = 0
    cart_items.each do |cart_item|
      if cart_item.product.price.present?
        sum += cart_item.quantity * cart_item.product.price
      end
    end
    sum
  end

  def clear!
    cart_items.destroy_all
  end
end
