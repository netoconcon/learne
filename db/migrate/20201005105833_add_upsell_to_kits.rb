class AddUpsellToKits < ActiveRecord::Migration[6.0]
  def change
    add_column :kits, :upsell, :boolean
  end
end
