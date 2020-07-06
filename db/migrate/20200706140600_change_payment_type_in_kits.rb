class ChangePaymentTypeInKits < ActiveRecord::Migration[6.0]
  def change
    change_column :kits, :payment_type, 'integer USING CAST(payment_type AS integer)'
  end
end
