class CreateKits < ActiveRecord::Migration[6.0]
  def change
    create_table :kits do |t|
      t.string :name
      t.string :description
      t.integer :payment_type
      t.integer :standard_installments
      t.integer :maximum_installments
      t.integer :shipment_cost
      t.string :shipment_description
      t.boolean :allow_free_shipment
      t.integer :weight
      t.integer :width
      t.integer :height
      t.integer :length

      t.timestamps
    end
  end
end
