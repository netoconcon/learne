class Order < ApplicationRecord
  include Validation 

  after_create: send_email

  belongs_to :kit
  belongs_to :address
  belongs_to :customer

  normalize_attributes :phone, with: [:phone]
  normalize_attributes :zipcode, with: [:numbers]
  normalize_attributes :cpf, with: [:cpf]

  private

  def send_email
    OrderMailer.confirmation(self).deliver_now
  end

end
