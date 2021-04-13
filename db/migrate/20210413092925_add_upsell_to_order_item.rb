class AddUpsellToOrderItem < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :upsell, :boolean
    OrderItem.update_all upsell: false
    change_column_null :order_items, :upsell, false
  end
end
