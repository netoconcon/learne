class ImproveUpsell < ActiveRecord::Migration[6.0]
  def change
    add_column :kit_products, :upsell, :boolean, default: false, null: false
    add_column :kits, :upsell_message, :string

    Kit.all.each do |kit|
      kit.update! upsell_message: kit.copy
    
      kit_product = KitProduct.find_by(product_id: kit.upsell_product_id, kit_id: kit.id)
      kit_product.update! upsell: kit_product.present?
    end

    remove_column :kits, :upsell_product_id
    remove_column :kits, :possale
    remove_column :kits, :copy
  end
end
