class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @orders = Order.all
    @all_prices = []
    @all_prices = Order.all.each do |order|
      @all_prices  < order.price
    end
    testing
  end

  def method_name
    # created_at.strftime("%Y-%m-%d")
  end

  def testing
    @products = Product.all
    @a = Product.group_by_day(:created_at, last:7, format: "%d/%m").count
    @today = Time.now.strftime("%d-%m")
  end
  # <%= line_chart @products.map { |order| { name: order.name, data: order.virtual.group_by_day(:created_at, format: "%d/%m").count} } %>
end
