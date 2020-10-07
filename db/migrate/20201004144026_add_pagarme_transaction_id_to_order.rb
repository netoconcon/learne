class AddPagarmeTransactionIdToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :pagarme_transaction_id, :string
    add_column :orders, :boleto_url, :string
    add_column :orders, :boleto_bar_code, :string
  end
end
