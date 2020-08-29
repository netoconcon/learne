module Order::Validation
  extend ActiveSupport::Concern

  included do
    validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  end
end
