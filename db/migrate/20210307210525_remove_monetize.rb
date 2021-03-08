class RemoveMonetize < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :price, :decimal, precision: 8, scale: 2
    add_column :kit_products, :price, :decimal, precision: 8, scale: 2
    add_column :kits, :amount, :decimal, precision: 8, scale: 2
    add_column :kits, :shipment_cost, :decimal, precision: 8, scale: 2
    
    Product.all.each do |product|
      product.update! price: (BigDecimal(product.price_cents) / 100)
    end

    KitProduct.all.each do |kit_product|
      kit_product.update! price: (BigDecimal(product.price_cents) / 100)
    end

    Kit.all.each do |kit|
      kit.update! amount: (BigDecimal(product.amount_cents) / 100), shipment_cost: (BigDecimal(product.shipment_cost_cents) / 100)
    end

    remove_column :products, :price_cents
    remove_column :kit_products, :price_cents
    remove_column :kits, :amount_cents
    remove_column :kits, :shipment_cost_cents
  end
end
