class Product < ApplicationRecord

  validates :name, :company, :price_cents, presence: true
  validates_numericality_of :price_cents, :greater_than_or_equal_to => 0

  belongs_to :company
  belongs_to :upsell, optional: true

  has_many :kit_products, dependent: :destroy
  has_many :kits, through: :kit_products

  has_many :upsells, dependent: :destroy
  has_many :kits, through: :upsells

  monetize :price_cents
  
end
