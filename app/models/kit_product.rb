class KitProduct < ApplicationRecord
  belongs_to :product
  belongs_to :kit

  default_scope {order(created_at: :asc)}
end
