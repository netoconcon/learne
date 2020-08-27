class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

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
    @a = Order.group(:payment_method).group_by_day(:created_at, last:7, format: "%d/%m").sum('orders.price')



    @b = Order.group(:payment_method).where(payment_method: true).group_by_day(:created_at, last:7, format: "%d/%m").count
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
