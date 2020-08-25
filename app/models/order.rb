class Order < ApplicationRecord
  include Validation

  belongs_to :kit
  belongs_to :address

  normalize_attributes :phone, with: [:phone]
  normalize_attributes :zipcode, with: [:numbers]
  normalize_attributes :cpf, with: [:cpf]

end
