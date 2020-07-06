class ChangePaymentTypeInKits < ActiveRecord::Migration[6.0]
  def change
    change_column :kits, :payment_type, :intege
  end
end
