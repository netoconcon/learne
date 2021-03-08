class Admin::OrdersController < ApplicationController
  layout "admin"

  def index
    sql_query = ""

    # select / reject params
    status = params[:status]
    payment = params[:payment]
    start_date = params[:start_date]
    end_date = params[:end_date]
    origin = params[:origin]
    id = params[:id]

    # pg search params
    name = params[:name]
    address = params[:address]
    cep = params[:zip]
    cpf = params[:cpf]
    phone = params[:phone]

    # PG SEARCH
    if name.present? || address.present? || cep.present? || cpf.present? || phone.present?
      # sql_query = [id, name, address, cep, cpf, phone].join(" ")
      sql_query = [id, name, address].join(" ")
      @orders = Order.search_by_fields(sql_query)
    else
      @orders = Order.all.order('created_at DESC')
    end

    # BRUTE SEARCH
    if id.present?
      @orders = @orders.select {|order| order.id == id.to_i}
    end


    # BRUTE SEARCH
    if status.present?
      if status == "Em Aberto"
        @orders = @orders.reject { |order| order.paid }
        @orders = @orders.select { |order| order.status == "completed" || order.status == "pending_payment" }
      elsif status == "Paga"
        @orders = @orders.select { |order| order.paid }
      elsif status == "Recusada"
        @orders = @orders.reject { |order| order.paid }
        @orders = @orders.reject { |order| order.status == "completed" || order.status == "pending_payment" }
      end
    end

    # BRUTE SEARCH
    if payment.present?
      if payment == "cartao"
        @orders = @orders.select { |order| order.payment_method }
      else
        @orders = @orders.reject { |order| order.payment_method }
      end
    end

    # BRUTE SEARCH
    if start_date.present?
      @orders = @orders.select {|order| order.created_at >= start_date}
    else
      @start_date = Date.today
    end
    if end_date.present?
      @orders = @orders.select {|order| order.created_at <= end_date}
    else
      @end_date = Date.today
    end
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

