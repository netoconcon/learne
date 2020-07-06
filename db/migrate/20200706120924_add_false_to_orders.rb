class AddFalseToOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :paid, :boolean, default: false
    change_column :orders, :payment_method, :boolean, default: false
  end
end
