module OrderStatusHelper
  def humanize_order_status(status)
  	if status == "completed"
  		"Paga"
  	elsif status == "pending_payment"
  		"Pendente"
  	else
  		"Recusada"
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
      "Cartão de Crédito"
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
