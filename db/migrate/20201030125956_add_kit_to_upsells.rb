class AddKitToUpsells < ActiveRecord::Migration[6.0]
  def change
    add_reference :upsells, :kit, null: false, foreign_key: true
  end
end
