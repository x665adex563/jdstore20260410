class Order < ApplicationRecord
  validates :billing_name, :billing_address, presence: true
  validates :shipping_name, :shipping_address, presence: true

  belongs_to :user
  has_many :product_lists, dependent: :destroy
  has_secure_token

  def to_param
    token
  end
end
