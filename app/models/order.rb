class Order < ApplicationRecord
  include Validation

  belongs_to :kit
  belongs_to :address
  belongs_to :customer
  has_many :visits

  enum status: {
      pending_payment: 0,   # User completed the checkout, we must wait confirmation
      completed: 1,         # Everything went fine.
      failed: 2,            # Unfortunately something went wrong
  }

  normalize_attributes :phone, with: [:phone]
  normalize_attributes :zipcode, with: [:numbers]
  normalize_attributes :cpf, with: [:cpf]

  private

  def send_email
    OrderMailer.confirmation.deliver_now
  end
end
