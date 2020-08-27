class RemoveColumnsFromOrder < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :first_name, :string
    remove_column :orders, :last_name, :string
    remove_column :orders, :email, :string
    remove_column :orders, :phone, :string
    remove_column :orders, :zipcode, :string
    remove_column :orders, :street, :string
    remove_column :orders, :street_number, :integer
    remove_column :orders, :neighborhood, :string
    remove_column :orders, :city, :string
    remove_column :orders, :state, :string
    remove_column :orders, :complement, :string
    remove_column :orders, :cpf, :string
    remove_column :orders, :birthday, :string
  end
end
