class Order < ApplicationRecord
  include Validation

  validates :email, presence: true, format: Validation.email
  validates :first_name, :last_name, :phone, :zipcode, :street, :street_number, presence: true
  validates :neighborhood, :city, :state, :complement, :price_cents, :CPF, :birthday, presence: true

  belongs_to :kit
end
