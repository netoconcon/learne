class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :pagarme_card
      t.string :card_fingerprint

      t.timestamps
    end
  end
end
