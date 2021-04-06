class RemoveMonetize < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :price, :decimal, precision: 8, scale: 2
    add_column :kit_products, :price, :decimal, precision: 8, scale: 2
    add_column :kits, :amount, :decimal, precision: 8, scale: 2
    add_column :kits, :shipment_cost, :decimal, precision: 8, scale: 2
    
    Product.all.update_all("price = price_cents / 100")

    KitProduct.all.update_all("price = price_cents / 100")

    Kit.all.update_all("amount = amount_cents / 100")
    Kit.all.update_all("shipment_cost = shipment_cost_cents / 100")

    remove_column :products, :price_cents
    remove_column :kit_products, :price_cents
    remove_column :kits, :amount_cents
    remove_column :kits, :shipment_cost_cents
  end
end
