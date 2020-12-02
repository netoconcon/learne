# frozen_string_literal: true

class Pm::Subscription
  def self.create(order)
    payload = Pm::Adapter::Subscription.new(order).payload

    data = PagarMe::Subscription.new(payload).create
    data
  rescue => message
    Rails.logger.debug(message)
    return nil
  end
end
