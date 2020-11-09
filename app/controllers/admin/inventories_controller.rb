class Admin::InventoriesController < ApplicationController
  layout "admin"

  def index
    @invetories = Inventory.all
    # @products = Product.all.where(virtual: false)
  end

  private

  def product_params
    params.require(:inventory).permit(:product_id, :quantity)
  end
end