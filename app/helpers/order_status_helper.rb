module OrderStatusHelper
  def humanize_order_status(order)
    if order.completed?
      "Paga"
    elsif order.pending_payment?
      "Em Aberto"
    elsif order.refused?
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

  def humanize_order_total_value(order)
    final_price = (order.amount.to_i + order.kit.shipment_cost)
    real_price = final_price / 100
    cents = (final_price - real_price).to_s.first(2)
    "R$ #{real_price},#{cents}"
  end
end
