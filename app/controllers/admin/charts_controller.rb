class Admin::ChartsController < ApplicationController
  layout "admin"

  def values

    card = Order.where(payment_method: true).group_by_day(:created_at, last:7, format: "%d/%m").sum('orders.price')
    boleto_paid = Order.where(payment_method: false).group_by_day(:created_at, last:7, format: "%d/%m").sum('orders.price')
    render json: [
      {name: "Cartao", data: card},
      {name: "Boleto pagos", data: boleto_paid},
      {name: "Estorno", data: 0},
      {name: "Chargeback", data: 0}
    ]
  end
end
