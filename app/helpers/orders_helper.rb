module OrdersHelper
  def order_installments(order)
    if Kit.find_by(id: order.kit_id).payment_type == "subscription"
      installments = []
      order.kit.maximum_installments.times do |index|
        installment_price = KitProduct.find_by(kit_id: order.kit_id).price  / (index + 1)
        installments << ["#{index + 1} X #{number_to_currency(installment_price, unit: "R$ ", separator: ",")}", index]
      end
      installments
    else
      installments = ["1 X #{number_to_currency(order.kit.price, unit: "R$ ", separator: ",")}"]      
    end
  end
end
