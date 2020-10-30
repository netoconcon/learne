class Upsell < ApplicationRecord
  belongs_to :product
  belongs_to :kit

  accepts_nested_attributes_for :product, allow_destroy: true

end
