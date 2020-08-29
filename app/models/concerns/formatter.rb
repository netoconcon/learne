module Formatter
  extend ActiveSupport::Concern

  def self.email
    { with: /\A([^@]+@[^\.]+\..+)\z/ }
  end

  def self.cnpj
    { with: /\A([0-9]{2}\.?[0-9]{3}\.?[0-9]{3}\/?[0-9]{4}\-?[0-9]{2})\z/ } 
  end

  def self.phone
    { with: /\A(\([0-9]{2}\) [0-9]?[0-9]{4}-[0-9]{4})\z/ }
  end

  def self.zipcode
    { with: /\A\d{8}\z/ }
  end

  def self.cpf
    { with: /\A\d{3}\.\d{3}\.\d{3}\-\d{2}\z/ }
  end
end