class AddDiscountToKits < ActiveRecord::Migration[6.0]
  def change
    add_column :kits, :discount, :integer
  end
end
