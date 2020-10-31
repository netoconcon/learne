class Product < ApplicationRecord

  validates :name, :company, :price_cents, presence: true

  belongs_to :company
  belongs_to :upsell, optional: true

  has_many :kit_products, dependent: :destroy
  has_many :kits, through: :kit_products

  has_many :upsells, dependent: :destroy
  has_many :kits, through: :upsells

  monetize :price_cents
  
end
