class Order < ApplicationRecord
  include Validation

  belongs_to :kit
  belongs_to :address
  belongs_to :customer
  has_many :visits

  enum status: {
      pending_payment: 0,   # User completed the checkout, we must wait confirmation
      completed: 1,         # Everything went fine.
      refused: 2,            # Unfortunately something went wrong
  }

  normalize_attributes :phone, with: [:phone]
  normalize_attributes :zipcode, with: [:numbers]
  normalize_attributes :cpf, with: [:cpf]

  def order_status
    transaction = PagarMe::Transaction.find_by_id(self.pagarme_transaction_id.to_i)
    self.status = transaction["status"]
    self.save

    case self.status
    when "paid"
      order.status = "completed"
    when "pending_payment"
      order.status = "pending_payment"
    when "unpaid"
      order.status = "refused"
    when "canceled"
      order.status = "refused"
    else
      order.status = "refused"
    end
  end

  private

  def send_email
    OrderMailer.confirmation.deliver_now
  end
end
