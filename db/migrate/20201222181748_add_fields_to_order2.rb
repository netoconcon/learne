class AddFieldsToOrder2 < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :insts, :string
  end
end
