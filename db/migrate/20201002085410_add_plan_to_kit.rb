class AddPlanToKit < ActiveRecord::Migration[6.0]
  def change
    add_reference :kits, :plan, foreign_key: true
  end
end
