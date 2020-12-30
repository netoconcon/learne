class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
