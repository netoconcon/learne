class Company < ApplicationRecord
  has_many :bank_accounts
  has_many :products
end
