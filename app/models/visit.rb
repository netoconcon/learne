class Visit < ApplicationRecord
  belongs_to :order, optional: true
end
