class AddNullFalseToOrder < ActiveRecord::Migration[6.1]
  def change
    change_column_null :orders, :shipment_amount, false
    change_column_null :orders, :products_amount, false
  end
end
