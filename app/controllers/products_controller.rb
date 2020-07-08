class ProductsController < ApplicationController
  def index
    
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.company_id = params[:company_id]
    if @product.save!
      redirect_to companies_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :sku, :price, :description, :external_id, :weight, :height, :length, :virtual_url)   
  end
end
