class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @orders = Order.all
    @all_prices = []
    Order.all.each do |order|
      @all_prices  << order.price
    end
    chart
    order_card
    order_boleto
    boleto_generated
  end

  def method_name
    # created_at.strftime("%Y-%m-%d")
  end

  def chart
    @products = Product.all
    @a = Product.group_by_day(:created_at, last:7, format: "%d/%m").count
    @today = Time.now.strftime("%d-%m")
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
