class Kit < ApplicationRecord
  has_many :kit_products
  has_many :products, through: :kit_products

  enum payment_type: { single: 0, subscription: 1 }, _suffix: :payment
end
