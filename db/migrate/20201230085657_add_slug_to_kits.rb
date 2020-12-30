class AddSlugToKits < ActiveRecord::Migration[6.0]
  def change
    add_column :kits, :slug, :string

    Kit.all.each do |kit|
      kit.update! slug: kit.name.parameterize
    end

    change_column_null :kits, :slug, false
  end
end
