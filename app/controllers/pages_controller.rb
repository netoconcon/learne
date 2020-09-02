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
  end

  def order_card
    @orders_card = Order.all.where(payment_method: true)
    @testando = Order.all.where(payment_method: true)
    @cards_prices = []
    @orders_card.each do |order|
      @cards_prices << order.price
    end
    @testando = "eita"
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

end
