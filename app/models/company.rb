class Company < ApplicationRecord
  includes Email

  validates_format_of :email_support, :email_notification,  :with => Devise::email_regexp

  has_many :bank_accounts, dependent: :destroy
  has_many :products, dependent: :destroy
  default_scope {order(created_at: :asc)}
end
