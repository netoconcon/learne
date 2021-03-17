# frozen_string_literal: true

class Pm::Transaction
  def self.create(order)
    payload = Pm::Adapter::Transaction.new(order).payload
    debugger

    data = PagarMe::Transaction.new(payload).charge
    data
  rescue => message
    Rails.logger.debug(message)
    return nil
  end
end
