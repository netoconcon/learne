class Kit < ApplicationRecord


  validates :name, :amount_cents,:payment_type, :height, :weight, :width, :length, :shipment_cost_cents, presence: true

  validates :plan, presence: true, if: -> {self.payment_type == 'subscription'}
  validates :standard_installments, :maximum_installments, presence: true, if: -> {self.payment_type == 'single'}
  validates :shipment_cost_cents, presence: true, if: -> {self.allow_free_shipment == false}
  validates :possale, inclusion: { in: [true, false] }
  validates :name, uniqueness: true


  validates_numericality_of :shipment_cost_cents, :greater_than_or_equal_to => 0

  belongs_to :plan, optional: true
  has_many :orders, dependent: :destroy
  has_many :selling_pages, dependent: :destroy
  has_many :kit_products, dependent: :destroy
  has_many :products, through: :kit_products, dependent: :destroy

  accepts_nested_attributes_for :kit_products, reject_if: :all_blank, allow_destroy: true

  before_save :update_slug


  default_scope {order(created_at: :asc)}

  monetize :shipment_cost_cents
  monetize :amount_cents

  enum payment_type: { single: 0, subscription: 1 }, _suffix: :payment

  def price
    products.map(&:price).sum
  end

  def update_slug
    self.slug = name.parameterize
  end
end
