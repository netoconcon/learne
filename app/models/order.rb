class Order < ApplicationRecord
  include Validation

  validates :email, presence: true, format: Validation.email
  validates :phone, presence: true, format: Validation.phone
  validates :zipcode, presence: true, format: Validation.zipcode
  validates :CPF, presence: true, format: Validation.cpf
  validates :first_name, :last_name, :street, :street_number, presence: true
  validates :neighborhood, :city, :state, :complement, :price_cents, :birthday, presence: true

  belongs_to :kit
end
