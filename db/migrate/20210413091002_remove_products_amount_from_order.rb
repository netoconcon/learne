class RemoveProductsAmountFromOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :products_amount, :decimal
  end
end
