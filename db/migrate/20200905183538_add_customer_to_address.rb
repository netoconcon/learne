class AddCustomerToAddress < ActiveRecord::Migration[6.0]
  def change
    add_reference :addresses, :customer, null: false, foreign_key: true
  end
end
