class FixCampaign < ActiveRecord::Migration[6.0]
  def change
    add_reference :selling_pages, :product, foreign_key: true
    add_column :kits, :confirmation_page, :string
    SellingPage.all.each do |page|
      page.update! product: page.kit.products.first
      page.kit.update! confirmation_page: page.confirmation_page
    end
    remove_reference :selling_pages, :kit
    remove_column :selling_pages, :confirmation_page
    change_column_null :selling_pages, :product_id, false

    change_column :campaigns, :utm_campaign, :string, unique: true
    change_column :campaigns, :utm_content, :string, unique: true
    change_column :campaigns, :utm_term, :string, unique: true
    change_column :campaigns, :utm_medium, :string, unique: true
    change_column :campaigns, :utm_source, :string, unique: true
    change_column :campaigns, :fbid, :string, unique: true
    change_column :campaigns, :pubid, :string, unique: true
    change_column :campaigns, :title, :string, unique: true
  end
end
