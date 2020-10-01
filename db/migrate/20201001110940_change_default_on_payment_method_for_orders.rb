class ChangeDefaultOnPaymentMethodForOrders < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:orders, :payment_method, nil)
  end
end
