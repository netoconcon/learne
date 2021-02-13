class AddDateToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :expiration_date, :datetime
  end
end
