class AddShipmentAmountToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :shipment_amount, :decimal

    ActiveRecord::Base.connection.execute("UPDATE orders SET shipment_amount = k.shipment_cost FROM orders AS o INNER JOIN kits AS k ON o.kit_id = k.id")
    Order.where(shipment_amount: nil).update_all("shipment_amount = 0")
  end
end
