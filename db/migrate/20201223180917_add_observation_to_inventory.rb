class AddObservationToInventory < ActiveRecord::Migration[6.0]
  def change
    add_column :inventories, :observation, :text
  end
end
