class Admin::KitsController < ApplicationController
  layout "admin"

  def index
    @kits = Kit.all
    @products = Product.all
  end

  def new
    @kit = Kit.new
    gon.products = products
    deactivated_plans
    if(params.has_key?(:aux))
      @test = Product.find(params[:aux])
    end
  end

  def create
    @kit = Kit.new(kit_params)
    @product = params[:product_id]
    if @kit.save
      redirect_to admin_kits_path
    else
      render :new
    end
  end

  def edit
    @plans = Plan.all
    gon.products = products
    @kit = Kit.find(params[:id])
    @kit_product = KitProduct.new
    @products = Product.all
  end

  def update
    @kit = Kit.find(params[:id])
    @kit.update(kit_params)
    if @kit.save
      redirect_to admin_kits_path
    else
      render :edit
    end
  end

  def destroy
    @kit = Kit.find(params[:id])
    @kit.destroy
    redirect_to admin_kits_path
  end

  def products
    listproducts = Hash.new
    products = Product.all
    products.each { |x| listproducts[x]}
  end

  private

  def kit_params
    params.require(:kit).permit(
      :name,
      :description,
      :payment_type,
      :standard_installments,
      :maximum_installments,
      :shipment_cost,
      :allow_free_shipment,
      :weight,
      :height,
      :length,
      :width,
      :plan_id,
      kit_products_attributes:[
        :id,
        :product_id,
        :kit_id,
        :quantity,
        :price_cents,
        :_destroy,
        product_attributes:[
          :id,
          :company_id,
          :name,
          :sku,
          :price,
          :description,
          :external_id,
          :weight,
          :height,
          :length,
          :virtual_url
    ]])
  end

  def deactivated_plans
    Plan.all.find_by(active: false)
  end
end
