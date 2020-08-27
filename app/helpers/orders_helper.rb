module OrdersHelper
  def order_installments(order)
    installments = []
    order.kit.maximum_installments.times do |index|
      installment_price = order.kit.price  / (index + 1)
      installments << ["#{index + 1} X #{number_to_currency(installment_price, unit: "R$ ", separator: ",")}", index]
    end
    installments
  end
end