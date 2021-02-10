class Customer < ApplicationRecord
  has_many :addresses
  has_many :orders

  def name
    "#{first_name} #{last_name}"
  end
end
