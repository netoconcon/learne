class KitsController < ApplicationController
  def index
    @kits = Kit.all
  end

  def new
    @kit = Kit.new
  end

  def create
    @kit = Kit.new(kit_params)
    @product = params[:product_id]
    if @kit.save!
      redirect_to kits_path
    else
      render :new
    end
  end

  def edit
    @kit = Kit.find(params[:id])
  end

  def update
    @kit = Kit.find(params[:id])
    @kit.update(kit_params)
    if @kit.save!
      redirect_to kits_path
    else
      render :new
    end
  end

  def destroy
    @kit = Kit.find(params[:id])
    @kit.destroy
    redirect_to kits_path
  end


  private

  def kit_params
    params.require(:kit).permit(:name, :description, :payment_type, :standard_installments, :maximum_installments, :shipment_cost, :allow_free_shipment, :weight, :height, :length)   
  end
end
