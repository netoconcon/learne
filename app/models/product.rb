class Product < ApplicationRecord

  validates :name, :company, :price, presence: true
  validates_numericality_of :price, :greater_than_or_equal_to => 0

  belongs_to :company
  belongs_to :upsell, optional: true

  has_many :kit_products, dependent: :destroy
  has_many :kits, through: :kit_products
  has_many :selling_pages

  has_many :upsells, dependent: :destroy
  has_many :kits, through: :upsells

  has_one_attached :photo
end
