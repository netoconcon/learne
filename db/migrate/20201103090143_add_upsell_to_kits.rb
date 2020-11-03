class AddUpsellToKits < ActiveRecord::Migration[6.0]
  def change
    add_column :kits, :upsell, :string
  end
end
