class Kit < ApplicationRecord

  validates :plan, presence: true, if: -> {self.payment_type == 'subscription'}
  validates :standard_installments, :maximum_installments, presence: true, if: -> {self.payment_type == 'single'}
  validates :name, uniqueness: true

  belongs_to :plan, optional: true
  has_many :orders, dependent: :destroy
  has_many :kit_products, dependent: :destroy
  has_many :products, through: :kit_products, dependent: :destroy
  

  has_one_attached :banner

  accepts_nested_attributes_for :kit_products, reject_if: :all_blank, allow_destroy: true

  before_save :update_slug

  default_scope { order(created_at: :asc) }

  enum payment_type: { single: 0, subscription: 1 }, _suffix: :payment

  def update_slug
    self.slug = name.parameterize
  end

  def main_products
    KitProduct.where(upsell: false, kit_id: id)
  end

  def upsell_products
    KitProduct.where(upsell: true, kit_id: id)
  end

  def upsell?
    upsell_products.any?
  end
end
