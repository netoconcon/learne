class Admin::OrdersController < ApplicationController
  layout "admin"

  def index
    @orders = Order.all.order('created_at DESC')
  end

  def show
    @order = Order.find(params[:id])
  end
end
