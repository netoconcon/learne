class ChangePaymentTypeInLinks < ActiveRecord::Migration[6.0]
  def change
    change_column :kits, :payment_type, :integer
  end
end
