class Product < ApplicationRecord
  belongs_to :company
  
  has_many :kit_products, dependent: :destroy
  has_many :kits, through: :kit_products

  has_many :selling_pages, dependent: :destroy
end
