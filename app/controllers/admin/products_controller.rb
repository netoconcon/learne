class Admin::ProductsController < ApplicationController
  layout "admin"

  def index
    @products = Product.all.order('created_at ASC')
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @company = params[:company_id]
    if @product.save
      redirect_to admin_products_path
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
    if @product.save
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end


  private

  def product_params
    params.require(:product).permit(
      :company_id,
      :name,
      :sku,
      :price,
      :description,
      :virtual,
      :external_id,
      :width,
      :weight,
      :height,
      :length,
      :virtual_url,
      :photo,
      :cost
    )
  end

end
