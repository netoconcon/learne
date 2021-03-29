class Admin::OrdersController < ApplicationController
  layout "admin"

  def index

    # params
    @name = params[:name]
    @address = params[:address]
    @cep = params[:zip]
    @cpf = params[:cpf]
    @phone = params[:phone]
    @id = params[:id]
    @origin = params[:origin]
    @payment = params[:payment]
    @start_date = params[:start_date]
    @end_date = params[:end_date]

    # # FORMATER CPF CEP PHONE

    # PG SEARCH
    if @name.present? || @address.present? || @cep.present? || @cpf.present? || @phone.present?
      sql_query = [@name, @address].join(" ")
      @orders = Order.search_by_fields(sql_query)
    else
      @orders = Order.all.order('created_at DESC')
    end

    # BRUTE SEARCH
    if @id.present?
      @orders = @orders.select {|order| order.id == @id.to_i}
    end



    # BRUTE SEARCH
    if @origin.present?
      if @origin == "Equipe Parceira" || @origin == "Call Center"
        @orders = []
      else
        @orders
      end
    end



    # BRUTE SEARCH
    if @status.present?
      @show_status = "Status"
      if status == "Em Aberto"
        @orders = @orders.reject { |order| order.paid }
        @orders = @orders.select { |order| order.status == "completed" || order.status == "pending_payment" }
        @show_status = "Em Aberto"
      elsif status == "Paga"
        @orders = @orders.select { |order| order.paid }
        @show_status = "Paga"
      elsif status == "Recusada"
        @orders = @orders.reject { |order| order.paid }
        @orders = @orders.reject { |order| order.status == "completed" || order.status == "pending_payment" }
        @show_status = "Recusada"
      end
    end

    # # BRUTE SEARCH
    if @payment.present?
      if payment == "cartao"
        @orders = @orders.select { |order| order.payment_method }
      else
        @orders = @orders.reject { |order| order.payment_method }
      end
    end

    # BRUTE SEARCH
    if @start_date.present?
      @filter_start = @start_date
      @orders = @orders.select {|order| order.created_at >= @start_date}
    else
      @start_date = Date.today
      @filter_start = Date.today
    end

    if @end_date.present?
      @filter_end = @end_date
      @orders = @orders.select {|order| order.created_at <= @end_date}
    else
      @end_date = Date.today
      @filter_end = Date.today
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

