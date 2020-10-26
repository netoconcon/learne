class AddConfirmationPageToSellingPages < ActiveRecord::Migration[6.0]
  def change
    add_column :selling_pages, :confirmation_page, :string
  end
end
