class Kit < ApplicationRecord
  has_many :kit_products
  has_many :products, through: :kit_products
end
