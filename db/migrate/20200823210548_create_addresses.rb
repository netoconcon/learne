class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      t.string :neighborhood
      t.string :complement
      t.string :city
      t.string :state
      t.string :zipcode
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
