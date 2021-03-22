class AddShipmentAmountToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :shipment_amount, :decimal

    Order.all.each do |order|
      order.update! shipment_amount: order.kit.shipment_cost || 0, price: 1
    end
  end
end
