class BankAccount < ApplicationRecord
  validates :bank_code, presence: true, length: { in: 1..3 }, format: { with: /\A(\d{1,3})\z/, message: "Informar o codigo do banco" }
  validates :bank_name, presence: true
  validates :agency_number, presence: true, format: { with: /\A(\d{4}-[0-9])\z/, message: "Digitar numero da agencia" }
  validates :account_number, presence: true, format: { with: /\A(^[0-9]+)\z/ }
  
  belongs_to :company
  
  default_scope {order(created_at: :asc)}

  # normalize_attributes :agency_number, with: [:agency_number]
  normalize_attributes :account_number, with: [:numbers]
  
end
