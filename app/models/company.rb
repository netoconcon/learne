class Company < ApplicationRecord
  include Email
  
  validates :cnpj, presence: true, format: { with: /\A(\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2})\z/ } 
  validates :name, presence: true
  validates :shipment_origin_zipcode, :allow_blank => true, format: { with: /\A\d{5}-\d{3}\z/ }
  validates :phone_support, :allow_blank => true , format: { with: /\A(([0-9]{2}\\)[0-9]?[0-9]{4}-[0-9]{4})\z/ }

  has_many :bank_accounts, dependent: :destroy
  has_many :products, dependent: :destroy
  default_scope {order(created_at: :asc)}
end
