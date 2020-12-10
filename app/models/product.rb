class Product < ApplicationRecord

  validates :name, :company, :price_cents, presence: true
  validates_numericality_of :price_cents, :greater_than_or_equal_to => 0

  belongs_to :company
  
  has_many :kit_products, dependent: :destroy
  has_many :kits, through: :kit_products

  monetize :price_cents
  
end
