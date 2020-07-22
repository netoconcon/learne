class BankAccount < ApplicationRecord
  include Bank

  belongs_to :company
  
  default_scope {order(created_at: :asc)}
end
