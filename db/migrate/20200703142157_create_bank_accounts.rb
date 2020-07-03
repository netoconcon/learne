class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts do |t|
      t.references :company, null: false, foreign_key: true
      t.integer :bank_code
      t.boolean :international
      t.string :bank_name
      t.string :agency_number
      t.string :account_number

      t.timestamps
    end
  end
end
