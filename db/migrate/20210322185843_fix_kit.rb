class FixKit < ActiveRecord::Migration[6.1]
  def change
    remove_column :kits, :price
    add_column :kits, :price, :decimal

    Kit.all.each do |kit|
      kit.update! price: kit.amount
    end

    remove_column :kits, :amount
  end
end
