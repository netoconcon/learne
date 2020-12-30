class FixUpsellInKit < ActiveRecord::Migration[6.0]
  def change
    add_reference :kits, :upsell_product, foreign_key: { to_table: :products }

    Kit.all.each do |kit|
      kit.update! upsell_product_id: kit.upsell if kit.upsell.present?
    end

    remove_column :kits, :upsell, :string
  end
end
