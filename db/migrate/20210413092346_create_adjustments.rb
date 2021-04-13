class CreateAdjustments < ActiveRecord::Migration[6.1]
  def change
    create_table :adjustments do |t|
      t.references :order, null: false, foreign_key: true
      t.decimal :amount
      t.references :source, polymorphic: true, null: false

      t.timestamps
    end
  end
end
