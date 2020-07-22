class Kit < ApplicationRecord

  validates :name, presence: true
  validates :standard_installments, presence: true
  validates :maximum_installments, presence: true
  validates :height, presence: true
  validates :weight, presence: true
  validates :width, presence: true
  validates :length, presence: true

  has_many :kit_products, dependent: :destroy
  has_many :products, through: :kit_products
  accepts_nested_attributes_for :kit_products, reject_if: :all_blank, allow_destroy: :true


  enum payment_type: { single: 0, subscription: 1 }, _suffix: :payment
end
