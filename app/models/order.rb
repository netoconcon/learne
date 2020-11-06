class Order < ApplicationRecord
  include Validation

  after_create :get_pagarmes_infos
  # after_create :send_email
  # after_update :send_update_email

  belongs_to :kit
  belongs_to :address
  belongs_to :customer
  has_many :visits

  normalize_attributes :phone, with: [:phone]
  normalize_attributes :zipcode, with: [:numbers]
  normalize_attributes :cpf, with: [:cpf]
  
  private

  def get_pagarmes_infos
    transaction_infos = PagarMe::Transaction.find_by_id(order.pagarme_transaction_id.to_i)
    self.refused_reason = transaction_infos.refuse_reason if transaction_infos.refused_reason
    self.status = transaction_infos.status
    self.boleto_url = transaction_infos.boleto_url if transaction_infos.boleto_url    # => boleto's URL
    self.boleto_bar_code =  transaction_infos.boleto_barcode if transaction_infos.boleto_barcode # => boleto's barcode
    self.save
  end

  def send_email
    OrderMailer.confirmation.deliver_now
  end

  # def send_update_email
  #   OrderMailer.update.deliver_now
  # end
end
