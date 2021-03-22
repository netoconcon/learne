class ChangeOrderAmountToProductsAmount < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :amount, :products_amount
  end
end
