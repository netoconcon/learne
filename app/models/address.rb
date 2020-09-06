class Address < ApplicationRecord
  include Validation

  belongs_to :customer

  normalize_attributes :zipcode, with: [:numbers]
end
