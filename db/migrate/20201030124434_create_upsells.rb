class CreateUpsells < ActiveRecord::Migration[6.0]
  def change
    create_table :upsells do |t|
      t.references :product, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
