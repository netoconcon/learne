class AddSlugToSellingPages < ActiveRecord::Migration[6.0]
  def change
    add_column :selling_pages, :slug, :string
    add_index :selling_pages, :slug, unique: true
  end
end
