class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @company = params[:company_id]
    if @product.save!
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    if @product.save!
      redirect_to products_path
    else
      render :new
    end
  end


  private

  def product_params
    params.require(:product).permit(:company_id, :name, :sku, :price, :description, :external_id, :weight, :height, :length, :virtual_url)   
  end
end
