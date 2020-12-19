module Order::Validation
  extend ActiveSupport::Concern

  included do
    validates :price, presence: true, numericality: { greater_than: 0 }
    validates :pagarme_transaction_id, presence: true, if: :completed?
  end
end
