class PagesController < ApplicationController
  layout "admin"

  def home
    @orders = Order.all
    @all_prices = []
    Order.all.each do |order|
      @all_prices  << order.price
    end
    order_card
    order_boleto
    boleto_generated
    chart
  end

  def method_name
    # created_at.strftime("%Y-%m-%d")
    # @today = Time.now.strftime("%d-%m")
  end

  def chart
    if Order.nil?
      @value_chart = Order.group(:payment_method).group_by_day(:created_at, last:7, format: "%d/%m").sum('orders.price')
      case Order.maximum("price") 
      when 0..2000
        @max = 2500
      when 2001..4000
        @max = 4500
      when 4001..6000
        @max = 6500
      when 6001..10000
        @max = 11000
      when 10001..15000
        @max = 17000
      when 15001..20000
        @max = 25000
      else
        @max = Order.maximum("price") + 5000
      end
    end
  end

  def order_card
    @orders_card = Order.all.where(payment_method: true)
    @cards_prices = []
    @orders_card.each do |order|
      @cards_prices << order.price
    end
  end

  def order_boleto
    @orders_boleto = Order.all.where(payment_method: false)
    @boletos_prices = []
    @orders_boleto.each do |order|
      @boletos_prices << order.price
    end
  end

  def boleto_generated
    @boletos = Order.all.where(payment_method: false).where(paid: false)
  end
  # <%= line_chart @products.map { |order| { name: order.name, data: order.virtual.group_by_day(:created_at, format: "%d/%m").count} } %>

end
