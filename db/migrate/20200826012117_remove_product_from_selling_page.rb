class RemoveProductFromSellingPage < ActiveRecord::Migration[6.0]
  def change
    remove_reference :selling_pages, :product, null: false, foreign_key: true
  end
end
