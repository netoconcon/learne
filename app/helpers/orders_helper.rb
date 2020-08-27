module OrdersHelper
  def order_installments(order)
    installments = []
    order.kit.maximum_installments.times do |index|
      installments << ["#{index} X #{number_to_currency(order.kit.price, unit: "R$ ", separator: ",") / index}", index]
    end
    installments
  end
end