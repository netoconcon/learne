class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.references :order, foreign_key: true
      t.string :fbid
      t.string :utm_source
      t.string :utm_campaign
      t.string :utm_medium
      t.string :utm_term
      t.string :utm_content
      t.string :pubid

      t.timestamps
    end
  end
end
