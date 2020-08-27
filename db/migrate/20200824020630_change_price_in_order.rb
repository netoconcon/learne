class ChangePriceInOrder < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :price, :decimal, null: false, precision: 8, scale: 2
  end
end
