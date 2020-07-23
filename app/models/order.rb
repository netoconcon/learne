class Order < ApplicationRecord
  validates :first_name, :last_name, :email, :phone, :zipcode, :street, :street_number, presence: true
  validates :neighborhood, :city, :state, :complement, :price_cents, :CPF, :birthday, presence: true

  belongs_to :kit
end
