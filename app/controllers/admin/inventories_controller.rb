class Admin::InventoriesController < ApplicationController
  layout "admin"

  def index
    @inventories = Inventory.all
    # @products = Product.all.where(virtual: false)
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.save
      redirect_to admin_inventories_path
    else
      render :new
    end
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])
    @inventory.update(inventory_params)
    if @inventory.save
      redirect_to admin_inventories_path
    else
      render :edit
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy
    redirect_to admin_inventories_path
  end

  private

  def inventory_params
    params.require(:inventory).permit(:product_id, :quantity)
  end
end