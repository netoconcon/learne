class Product < ApplicationRecord

  validates :name, :company, :price_cents, presence: true

  belongs_to :company
  has_one :inventory

  has_many :kit_products, dependent: :destroy
  has_many :kits, through: :kit_products

  monetize :price_cents
  
end
