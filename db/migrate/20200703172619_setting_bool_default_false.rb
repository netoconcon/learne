class SettingBoolDefaultFalse < ActiveRecord::Migration[6.0]
  def change
    change_column :bank_accounts, :international, :boolean, :default => false
    change_column :companies, :international, :boolean, :default => false
    change_column :kits, :allow_free_shipment, :boolean, :default => false
    change_column :products, :virtual, :boolean, :default => false
  end
end
