class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.boolean :international
      t.string :cnpj
      t.string :email_notification
      t.string :email_support
      t.string :phone_support
      t.string :shipment_origin_zipcode
      t.string :name

      t.timestamps
    end
  end
end
