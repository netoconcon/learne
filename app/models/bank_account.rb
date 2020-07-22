class BankAccount < ApplicationRecord
  belongs_to :company

  validates :bank_code, presence: true, format: { with: /\A(^(?:\D*\d){3}\D*$)\z/, message: "Informar o codigo do banco" }
  validates :bank_name, presence: true, format: { with: /\A(^([^0-9]*)$)\z/ }
  validates :agency_number, presence: true, format: { with: /\A(^(?:\D*\d){5}\D*$)\z/, message: "Digitar numero da agencia" }
  validates :account_number, presence: true, format: { with: /\A(^[0-9]+)\z/ }

  default_scope {order(created_at: :asc)}
end
