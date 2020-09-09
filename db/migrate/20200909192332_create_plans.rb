class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :pagarme_id
      t.integer :price
      t.integer :days
      t.integer :trial_days
      t.string :payment_methods
      t.integer :charges
      t.integer :installments
      t.integer :invoice_reminder
      t.boolean :active, default: false
      t.boolean :visible, default: false
      t.boolean :deactivated, default: false

      t.timestamps
    end
  end
end
