class AddObersationToInventory < ActiveRecord::Migration[6.0]
  def change
    add_column :inventories, :flag_quantities, :integer, default: 10
  end
end
