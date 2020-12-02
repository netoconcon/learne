# frozen_string_literal: true

class Pm::Customer
  def self.create(customer)
    payload = Pm::Adapter::Customer.new(customer).payload

    data = PagarMe::Customer.create(payload)
    data
  rescue => message
    Rails.logger.debug(message)
    return nil
  end
end
