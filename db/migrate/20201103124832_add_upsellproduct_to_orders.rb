class AddUpsellproductToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :upsell_product, :boolean
  end
end
