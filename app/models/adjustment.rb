class Adjustment < ApplicationRecord
  belongs_to :order
  belongs_to :source, polymorphic: true
end
