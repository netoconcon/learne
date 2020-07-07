class Company < ApplicationRecord
  has_many :bank_accounts, dependent: :destroy
  has_many :products
end
