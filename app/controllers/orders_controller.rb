class OrdersController < ApplicationController
  def new
    @order = OrderForm.new
  end

  def create
    @order = OrderForm.new(order_params)
  end

  private

  def order_params
    params.require(:kit).permit(
        :
    )
  end
end
