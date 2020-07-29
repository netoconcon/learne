module ApplicationHelper

  def kit_product_index
    show_products = []
    kit_products = KitProduct.all
    @kits.each do |kit|
      kit_products.each do |kit_product|
        if kit.id == kit_product.id
          show_products << kit_product
        end
      end
    end
    return show_products
  end
end
