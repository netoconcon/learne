class AddAmountToKits < ActiveRecord::Migration[6.0]
  def change
    remove_column :kits, :price_cents
    add_monetize :kits, :amount, currency: { present: false }
  end
end
