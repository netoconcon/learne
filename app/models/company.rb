class Company < ApplicationRecord
  validates :email_support, :email_notification, presence: true, format: Formatter.email
  validates :cnpj, presence: true, format: Formatter.cnpj
  validates :name, presence: true
  validates :shipment_origin_zipcode, :allow_blank => true, format: Formatter.zipcode
  validates :phone_support, :allow_blank => true , format: Formatter.phone

  has_many :bank_accounts, dependent: :destroy
  has_many :products, dependent: :destroy

  normalize_attributes :cnpj, with: [:cnpj]
  normalize_attributes :shipment_origin_zipcode, with: [:numbers]
  normalize_attributes :phone_support, with: [:phone]
end
