class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to products_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :phone, :paid, :installments, :kit_id, :payment_method, :zipcode, :street, :street_number, :neighborhood, :city, :state, :complement, :price, :CPF, :birthday, :kit_id)
  end
end
