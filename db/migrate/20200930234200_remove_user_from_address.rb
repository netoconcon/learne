class RemoveUserFromAddress < ActiveRecord::Migration[6.0]
  def change
    remove_reference :addresses, :user, null: false, foreign_key: true
  end
end
