class Company < ApplicationRecord
  has_many :bank_accounts, dependent: :destroy
  has_many :products, dependent: :destroy
  default_scope {order(created_at: :asc)}
end
