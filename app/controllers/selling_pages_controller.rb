class SellingPagesController < ApplicationController

  def show
    @selling_page = SellingPage.find(params[:id])
    @instances = KitProduct.where(id: @selling_page.kit.id)
  end

  def kit_show
    kit_id = SellingPage.find_by(url: params[:selling_page_url]).kit.id if SellingPage.nil?
    @order = OrderForm.new(kit_id: kit_id)
    render "orders/new"
  end

  private

  def selling_page_params
    params.require(:selling_page).permit(:kit_id, :name, :description, :url)
  end
end
