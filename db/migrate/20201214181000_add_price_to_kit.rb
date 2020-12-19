class AddPriceToKit < ActiveRecord::Migration[6.0]
  def change
    add_column :kits, :price, :integer
  end
end
