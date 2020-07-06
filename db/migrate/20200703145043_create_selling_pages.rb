class CreateSellingPages < ActiveRecord::Migration[6.0]
  def change
    create_table :selling_pages do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end
