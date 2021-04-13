class Order < ApplicationRecord
  include Validation
  include PgSearch::Model

  belongs_to :kit
  belongs_to :address
  belongs_to :customer
  has_many :visits
  has_many :order_items
  has_many :adjustments

  after_create :get_order_infos

  after_commit :send_order_confirmation

  enum status: {
      pending_payment: 0,   # User completed the checkout, we must wait confirmation
      completed: 1,         # Everything went fine.
      refused: 2,           # Unfortunately something went wrong
  }

  enum payment_method: { credit_card: 0, boleto: 1 }

  normalize_attributes :phone, with: [:phone]
  normalize_attributes :zipcode, with: [:numbers]
  normalize_attributes :cpf, with: [:cpf]


  pg_search_scope :search_by_fields,
    against: [ :paid, :installments, :kit_id, :payment_method, :price, :created_at, :updated_at, :address_id, :customer_id, :pagarme_transaction_id, :boleto_url, :boleto_bar_code, :upsell_product, :refused_reason, :status , :cpf ],
    associated_against: {
    kit: [:name, :description],
    address: [:street, :number, :neighborhood, :complement, :city, :state, :zipcode],
    customer: [:first_name, :last_name, :email, :phone, :cpf, :birthday],
    #   # visits: []
    },
    using: {
    tsearch: { prefix: true }
  }

  def get_order_infos
    unless self.pagarme_transaction_id.nil?
      transaction = PagarMe::Transaction.find_by_id(self.pagarme_transaction_id.to_i)
      self.boleto_url = transaction["boleto_url"]
      self.boleto_bar_code = transaction["boleto_barcode"]
      self.save
    end
  end

  def get_boleto_barcode
    unless self.pagarme_transaction_id.nil?
      transaction = PagarMe::Transaction.find_by_id(self.pagarme_transaction_id.to_i)
      boleto_url = transaction["boleto_url"]
      boleto_bar_code = transaction["boleto_barcode"]
    end
    return [boleto_url, boleto_bar_code]
  end
    
    
  def products_amount
    order_items.sum(&:price)
  end

  def adjustments_amount
    adjustments.sum(&:amount)
  end

  def total_amount
    shipment_amount + products_amount + adjustments_amount
  end

  private

  def send_order_confirmation
    OrderMailer.confirmation(self).deliver_now
  end
end
