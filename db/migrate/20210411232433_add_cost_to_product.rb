class AddCostToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :cost, :decimal

    Product.update_all cost: 0.01

    change_column_null :products, :cost, false
  end
end
