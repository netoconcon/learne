class KitProductsController < ApplicationController
  def index
    @kit_products = KitProduct.all
  end

  def new
    @kit_product = KitProduct.new  
  end

  def create
    @kit_product = KitProduct.new(kit_product_params)
    if @kit_product.save!
      redirect_to products_path
    else
      render :new
    end
  end

  private

  def kit_product_params
    params.require(:kit_product).permit(:product_id, :kit_id, :quantity, :price)   
  end
end
