class BankAccount < ApplicationRecord
  belongs_to :company


  default_scope {order(created_at: :asc)}
end
