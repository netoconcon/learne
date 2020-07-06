class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.boolean :paid
      t.integer :installments
      t.references :kit, null: false, foreign_key: true
      t.boolean :payment_method
      t.string :zipcode
      t.string :street
      t.string :street_number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :complement
      t.integer :price
      t.string :CPF
      t.date :birthday

      t.timestamps
    end
  end
end
