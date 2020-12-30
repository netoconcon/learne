class FixVisits < ActiveRecord::Migration[6.0]
  def change
    remove_reference :visits, :order
    add_reference :visits, :campaign

    remove_column :visits, :fbid
    remove_column :visits, :utm_source
    remove_column :visits, :utm_medium
    remove_column :visits, :utm_term
    remove_column :visits, :utm_content
    remove_column :visits, :utm_campaign
    remove_column :visits, :pubid
  end
end
