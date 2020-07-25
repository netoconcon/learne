class Company < ApplicationRecord
  include Validation

  validates :email_support, :email_notification, presence: true, format: Validation.email
  validates :cnpj, presence: true, format: Validation.cnpj
  validates :name, presence: true
  validates :shipment_origin_zipcode, :allow_blank => true, format: Validation.zipcode
  validates :phone_support, :allow_blank => true , format: Validation.phone

  has_many :bank_accounts, dependent: :destroy
  has_many :products, dependent: :destroy
  default_scope {order(created_at: :asc)}
  
end
