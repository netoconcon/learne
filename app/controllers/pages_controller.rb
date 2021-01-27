class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:developedby]
  layout "admin"

  def home
    if params[:start_date] || params[:end_date]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
    else
      current_month = Date.today.at_beginning_of_month
      @start_date = Date.today.at_beginning_of_month
      @end_date = Date.today.end_of_month
    end

    @orders = get_order_from_period(@start_date, @end_date)
    @total_sold = total_orders_sum(@orders)
    @average_ticket = @total_sold / @orders.count unless @orders.count.zero?

  


    
  end

  def total_orders_sum(orders)
    sum = 0
    orders.each do |order|
      sum += order.amount
    end
    sum
  end

  def get_order_from_period(start_date, end_date)
    orders = Order.all

    unless start_date.nil?
      orders = orders.select { |order| order.created_at >= start_date}
    end

    unless end_date.nil?
      orders = orders.select { |order| order.created_at <= end_date}
    end
    orders
  end

  def thanks
    @order = Order.find(params["format"])
  end

  private

  def dash_filter
  end

  def initial_date
    if params[:sales_date] == nil
      params[:sales_date] = Date.today
    end
  end

  def date_overview
    if @date.present?
      @all_prices = []
      @all_day_orders = Order.where(created_at: @date.to_date.midnight..@date.to_date.end_of_day)
      @all_day_orders.each  do |order|
        @all_prices  << order.price
      end
    else
      @all_prices = []
      @all_day_orders = Order.all
      @all_day_orders.each  do |order|
        @all_prices  << order.price
      end
    end
  end


  def order_card
    if @date.present?
    @orders_card = Order.all.where(payment_method: true).where(created_at: @date.to_date.midnight..@date.to_date.end_of_day)
    @cards_prices = []
    @orders_card.each do |order|
      @cards_prices << order.price
    end
    else
      @cards_prices = []
      @orders_card = Order.all.where(payment_method: true)
      @orders_card.each do |order|
        @cards_prices << order.price
      end
    end
  end

  def order_boleto
    if @date.present?
      @orders_boleto = Order.all.where(payment_method: false).where(created_at: @date.to_date.midnight..@date.to_date.end_of_day)
      @boletos_prices = []
      @orders_boleto.each do |order|
        @boletos_prices << order.price
      end
    else
      @boletos_prices = []
      @orders_boleto = Order.all.where(payment_method: false)
      @orders_boleto.each do |order|
        @boletos_prices << order.price
      end
    end
  end

  def boleto_generated
    @boletos = Order.all.where(payment_method: false).where(paid: false)
  end

  def developedby
    layout "application"
  end
end
