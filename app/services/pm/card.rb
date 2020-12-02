# frozen_string_literal: true

class Pm::Card
  def self.create(order)
    payload = Pm::Adapter::Card.new(order).payload

    data = PagarMe::Card.new(payload).create
    data
  rescue => message
    Rails.logger.debug(message)
    return nil
  end
end
