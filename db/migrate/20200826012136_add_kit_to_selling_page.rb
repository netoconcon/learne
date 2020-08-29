class AddKitToSellingPage < ActiveRecord::Migration[6.0]
  def change
    add_reference :selling_pages, :kit, null: false, foreign_key: true
  end
end
