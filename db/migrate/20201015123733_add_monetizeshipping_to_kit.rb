class AddMonetizeshippingToKit < ActiveRecord::Migration[6.0]
  def change
    remove_column :kits, :shipment_cost
    add_monetize :kits, :shipment_cost, currency: { present: false }
  end
end
