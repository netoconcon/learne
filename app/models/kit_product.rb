class KitProduct < ApplicationRecord

  delegate :photo, :name, to: :product
  validates :quantity, presence: true
  
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0

  belongs_to :product
  belongs_to :kit

  accepts_nested_attributes_for :product, reject_if: :all_blank, allow_destroy: true

  default_scope {order(created_at: :asc)}
  
end
