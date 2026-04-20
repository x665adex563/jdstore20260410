class Order < ApplicationRecord
  validates :billing_name, :billing_address, presence: true
  validates :shipping_name, :shipping_address, presence: true

  belongs_to :user
  has_many :product_lists, dependent: :destroy
  has_secure_token

  def to_param
    token
  end

  def set_payment_with!(method)
    update!(payment_method: method)
  end

  def pay!
    update!(is_paid: true)
  end

  include AASM

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_returned

    event :make_payment do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      transitions from: :paid,         to: :shipping
    end

    event :deliver do
      transitions from: :shipping,     to: :shipped
    end

    event :return_good do
      transitions from: :shipped,      to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end
end
