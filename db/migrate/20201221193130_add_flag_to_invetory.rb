class AddFlagToInvetory < ActiveRecord::Migration[6.0]
  def change
    add_column :inventories, :flag_quantities, :integer
  end
end
