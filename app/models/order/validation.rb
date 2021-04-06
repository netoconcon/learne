module Order::Validation
  extend ActiveSupport::Concern

  included do
    validates :pagarme_transaction_id, presence: true, if: :completed?
  end
end
