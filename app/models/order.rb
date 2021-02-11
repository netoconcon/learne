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

  def get_order_infos
    unless self.pagarme_transaction_id.nil?
      transaction = PagarMe::Transaction.find_by_id(self.pagarme_transaction_id.to_i)
      self.boleto_url = transaction["boleto_url"]
      self.boleto_bar_code = transaction["boleto_barcode"]
      self.expiration_date = transaction["boleto_expiration_date"]
      self.save
    end
  end

  private

  def send_email
    OrderMailer.confirmation.deliver_now
  end
end
