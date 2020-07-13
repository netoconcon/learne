class KitProductsController < ApplicationController
  def index
    @kit_products = KitProduct.all
    @list_products = @kit_products.where(kit_id: params["format"])
  end

  def new
    @kit_product = KitProduct.new
    @kit_id = params["format"]
  end

  def create
    @kit_product = KitProduct.new(kit_product_params)
    if @kit_product.save!
      redirect_to products_path
    else
      render :new
    end
  end

  def destroy
    @kit_product = KitProduct.find(params[:id])
    @kit_product.destroy
    redirect_to kit_products_path(kit_product)
  end

  private

  def kit_product_params
    params.require(:kit_product).permit(:product_id, :kit_id, :quantity, :price)   
  end
end
