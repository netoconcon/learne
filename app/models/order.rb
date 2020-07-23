class Order < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :zipcode, presence: true
  validates :street, presence: true
  validates :street_number, presence: true
  validates :neighborhood, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :complement, presence: true
  validates :price, presence: true
  validates :CPF, presence: true
  validates :birthday, presence: true


  belongs_to :kit
end
