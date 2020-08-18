class Product < ApplicationRecord

  validates :name, :company, :price_cents, presence: true

  belongs_to :company
  
  has_many :kit_products, dependent: :destroy
  has_many :kits, through: :kit_products

  has_many :selling_pages, dependent: :destroy

  monetize :price_cents

  normalize_attributes :price_cents, with: [:decimal]
  
end
