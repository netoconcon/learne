class RemovePriceFromKitproduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :kit_products, :price
    add_monetize :kit_products, :price, currency: { present: false }
  end
end
