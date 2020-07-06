class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :company, null: false, foreign_key: true
      t.boolean :virtual
      t.string :name
      t.string :sku
      t.integer :price
      t.string :description
      t.integer :external_id
      t.integer :weight
      t.integer :width
      t.integer :height
      t.integer :length
      t.string :virtual_url

      t.timestamps
    end
  end
end
