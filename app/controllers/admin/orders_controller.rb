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
    if @order.update(order_params)
      redirect_to admin_order_path(@order)
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:paid, :installments, :kit_id, :payment_method, :price, :address_id, :customer_id, :pagarme_transaction_id, :boleto_url, :boleto_bar_code, :upsell_product, :refused_reason, :status, :cpf, :insts, :amount, :expiration_date)
  end
end

