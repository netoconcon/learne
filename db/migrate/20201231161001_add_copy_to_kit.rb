class AddCopyToKit < ActiveRecord::Migration[6.0]
  def change
    add_column :kits, :copy, :text
  end
end
