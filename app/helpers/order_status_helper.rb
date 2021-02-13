module OrderStatusHelper
  def humanize_order_status(order)
  	if order.status == "completed"
  		if order.paid
        "Paga"
      else
        "Pendente"
      end
  	elsif status == "pending_payment"
  		"Não Processado"
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
