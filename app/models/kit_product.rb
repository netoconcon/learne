class KitProduct < ApplicationRecord
  belongs_to :product
  belongs_to :kit

  accepts_nested_attributes_for :product, reject_if: :all_blank, allow_destroy: true

  default_scope {order(created_at: :asc)}
end
