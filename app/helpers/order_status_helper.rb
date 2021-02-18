module OrderStatusHelper
  def humanize_order_status(order)
  	if order.paid
      "Paga"
    else
      if order.status == "completed"
        "Em Aberto"
      elsif order.status == "pending_payment"
        "Em Aberto"
      else
        "Recusada"
      end
    end
  end

  def humanize_order_paid(paid)
    if paid
      "Paga"
    else
      "Em aberto"
    end
  end

  def humanize_order_payment_method(method)
    if method
      "Cartão"
    else
      "Boleto"
    end
  end

  def humanize_order_total_value(order)
    final_price = (order.amount.to_i + order.kit.shipment_cost_cents)
    real_price = final_price / 100
    cents = (final_price - real_price).to_s.first(2)
    "R$ #{real_price},#{cents}"
  end
end
