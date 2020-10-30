class Admin::UpsellsController < ApplicationController
  def index
    @kit_products = KitProduct.all
    @list_products = @kit_products.where(kit_id: params["format"])
  end

  def new
    @upsell = Upsell.new
  end

  def create
    @upsell = Upsell.new(upsell_params)
    if @upsell.save
      redirect_to admin_kits_path
    else
      render :new
    end
  end

  def destroy
    @upsell = Upsell.find(params[:id])
    @upsell.destroy
    redirect_to admin_kits_path
  end

  private

  def upsell_params
    params.require(:upsell).permit(:product_id, :kit_id, :descritpion)
  end
end
