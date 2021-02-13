class Admin::OrdersController < ApplicationController
  layout "admin"

  def index
    @orders = Order.all.order('created_at DESC')
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update
      redirect_to admin_order_path(@order)
    else
      render :edit
    end
  end

  private

  def order_params

  end
end
