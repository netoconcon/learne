class Order < ApplicationRecord
  include Validation

<<<<<<< HEAD
  validates :email, presence: true, format: Validation.email
  validates :phone, presence: true, format: Validation.phone
  validates :zipcode, presence: true, format: Validation.zipcode
  validates :CPF, presence: true, format: Validation.cpf
  validates :first_name, :last_name, :street, :street_number, presence: true
  validates :neighborhood, :city, :state, :complement, :price, presence: true

=======
>>>>>>> 8f15b9c17c1c7f07dad90ba5488d0fe81a8e0f53
  belongs_to :kit
  belongs_to :address
  belongs_to :user

  normalize_attributes :phone, with: [:phone]
  normalize_attributes :zipcode, with: [:numbers]
  normalize_attributes :cpf, with: [:cpf]

end
