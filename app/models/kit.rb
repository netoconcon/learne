class Kit < ApplicationRecord

  validates :name, :standard_installments, :maximum_installments, :height, :weight, :width, :length, presence: true

  has_many :kit_products, dependent: :destroy
  has_many :products, through: :kit_products, dependent: :destroy
  accepts_nested_attributes_for :kit_products, reject_if: :all_blank, allow_destroy: :true

  default_scope {order(created_at: :asc)}

  enum payment_type: { single: 0, subscription: 1 }, _suffix: :payment

  def price
    kit_products.map(&:price_cents).sum
  end
end
