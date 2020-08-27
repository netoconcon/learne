class Order < ApplicationRecord
  include Validation

  validates :email, presence: true, format: Validation.email
  validates :phone, presence: true, format: Validation.phone
  validates :zipcode, presence: true, format: Validation.zipcode
  validates :CPF, presence: true, format: Validation.cpf
  validates :first_name, :last_name, :street, :street_number, presence: true
  validates :neighborhood, :city, :state, :complement, :price, presence: true

  belongs_to :kit

  normalize_attributes :phone, with: [:phone]
  normalize_attributes :zipcode, with: [:numbers]
  normalize_attributes :cpf, with: [:cpf]
  
end
