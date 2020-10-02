class KitProduct < ApplicationRecord

  validates :quantity, :price_cents, presence: true
  
  belongs_to :product
  belongs_to :kit

  accepts_nested_attributes_for :product, reject_if: :all_blank, allow_destroy: true

  default_scope {order(created_at: :asc)}

  monetize :price_cents
  
end
