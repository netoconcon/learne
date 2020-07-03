class CreateCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :campaigns do |t|
      t.references :selling_page, null: false, foreign_key: true
      t.string :fbid
      t.string :utm_source
      t.string :utm_campaign
      t.string :utm_medium
      t.string :utm_term
      t.string :utm_content
      t.string :pubid
      t.string :title

      t.timestamps
    end
  end
end
