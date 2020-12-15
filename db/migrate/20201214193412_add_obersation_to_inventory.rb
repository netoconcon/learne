class AddObersationToInventory < ActiveRecord::Migration[6.0]
  def change
    add_column :inventories, :observation, :string
  end
end
