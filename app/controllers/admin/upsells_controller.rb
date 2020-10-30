class Admin::UpsellsController < ApplicationController
  def index
    @upsell = Upsell.all
  end

  def new
    @upsell = Upsell.new
    @upsell.products_options.build
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
