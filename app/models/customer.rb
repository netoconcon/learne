class Customer < ApplicationRecord
  has_many :addresses
  has_many :orders

  def name
    "#{first_name} #{last_name}"
  end

  def total_spent
    total = 0
    self.orders.each do |order|
      order_total = order.price.to_i + order.shipment_amount.to_i
      total += order_total
    end
    total / 100
  end

  def pending_order
    self.orders.select { |order| order.completed? }
    orders.count
  end

  def left_carts
    self.orders.reject { |order| order.completed? }
    orders.count
  end
end
