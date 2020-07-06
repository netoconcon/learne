class CreateKitProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :kit_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :kit, null: false, foreign_key: true
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
