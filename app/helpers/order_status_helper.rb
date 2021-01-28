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
end