class Address < ApplicationRecord
  include Validation

  belongs_to :user

  has_many :orders

  normalize_attributes :zipcode, with: [:numbers]
end
