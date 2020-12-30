class FixCoulmnName < ActiveRecord::Migration[6.0]
  def change
    add_column :kits, :possale, :boolean
  end
end
