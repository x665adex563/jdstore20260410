class Order < ApplicationRecord
  validates :billing_name, :billing_address, presence: true
  validates :shipping_name, :shipping_address, presence: true

  belongs_to :user
end
