module Validation
  extend ActiveSupport::Concern

  def self.email
    { with: /\A([^@]+@[^\.]+\..+)\z/ }
  end

  def self.cnpj
    { with: /\A(\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2})\z/ } 
  end

  def self.phone
    { with: /\A(([0-9]{2}\\)[0-9]?[0-9]{4}-[0-9]{4})\z/ }
  end

  def self.zipcode
    { with: /\A\d{5}-\d{3}\z/ }
  end
end