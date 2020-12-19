class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:developedby]
  layout "admin"

  def home
    initial_date
    @date = params[:sales_date]
    date_overview
    order_card
    order_boleto
    boleto_generated
  end

  def thanks
    @order = Order.find(params["format"])
  end

  private

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
