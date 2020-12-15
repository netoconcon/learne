class RemoveKitToUpsells < ActiveRecord::Migration[6.0]
  def change
    remove_reference :upsells, :kit, index: true, foreign_key: true
  end
end
