class Admin::OrdersController < ApplicationController
  layout "admin"

  def index
    @orders = Order.all.sort_by(&:created_at)
  end

  def show
    @order = Order.find(params[:id])
  end
end
