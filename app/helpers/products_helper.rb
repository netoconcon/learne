module ProductsHelper
  def products_list
    Product.all.map { |product| [product.name, product.id] }
  end
end