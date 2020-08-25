class KitProduct < ApplicationRecord

  validates :quantity, :price_cents, presence: true
  
  belongs_to :product
  belongs_to :kit

  accepts_nested_attributes_for :product, reject_if: :all_blank, allow_destroy: true

  monetize :price_cents

  default_scope {order(created_at: :asc)}
end
