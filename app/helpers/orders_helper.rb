module OrdersHelper
  def order_shipping(order)
      number_to_currency(order.kit.shipment_cost, unit: "R$ ")
  end

  def products(order)
    products_price = []
    KitProduct.where(kit: order.kit).each do |order|
      products_price << order.price
    end
    number_to_currency(products_price.sum, unit: "R$ ", separator: ",")
  end

  def order_installments(order)
    if Kit.find_by(id: order.kit_id).payment_type == "single"
      installments = []
      products_prices = []
      KitProduct.where(kit_id: order.kit_id).each do |order|
        products_prices << order.price
      end
      total_price = products_prices.sum + order.kit.shipment_cost
      order.kit.maximum_installments.times do |index|
        installment_price = total_price  / (index + 1)
        installments << ["#{index + 1} X #{number_to_currency(installment_price, unit: "R$ ", separator: ",")}", index]
      end
      installments
    else
      products_price = []
      KitProduct.where(kit_id: order.kit_id).each do |order|
        products_price << order.price
      end
      total_price = products_price.sum + order.kit.shipment_cost
      installments = ["1 X #{number_to_currency(total_price, unit: "R$ ", separator: ",")}"]      
    end
  end

  def order_single(order)
    total_price = []
    KitProduct.where(kit_id: order.kit_id).each do |order|
      total_price << order.price
    end
    total_price = number_to_currency(total_price.sum, unit: "R$ ", separator: ",")
  end
  
  def order_total_price(order)
    products_price = []
    KitProduct.where(kit: order.kit).each do |order|
      products_price << order.price
    end
    number_to_currency(order.kit.shipment_cost + products_price.sum, unit: "R$ ", separator: ",")
  end

end
