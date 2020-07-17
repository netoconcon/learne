class Product < ApplicationRecord
  belongs_to :company
  
  has_many :kit_products, dependent: :destroy
  has_many :kits, through: :kit_products

  has_many :selling_pages, dependent: :destroy

  monetize :price_cents
  default_scope {order(created_at: :asc)}
end
