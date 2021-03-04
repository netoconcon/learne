class ImproveUpsell < ActiveRecord::Migration[6.0]
  def change
    add_column :kit_products, :upsell, :boolean, default: false, null: false
    Kit.all.each do |kit|
      kit_product = KitProduct.find_by(product_id: kit.upsell_product_id, kit_id: kit.id)
      kit_product.update! upsell: true if kit_product.present?
    end
    remove_column :kits, :upsell_product_id, :integer
    remove_column :kits, :possale, :integer
  end
end
