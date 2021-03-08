module InterestHelper
  def order_interest(order)
  	amount = order.kit.amount + order.kit.shipment_cost
  	max_installments = order.kit.maximum_installments

	installments_result = PagarMe::Transaction.calculate_installments({
		amount: (amount * 100).to_i,
		interest_rate: 2.99,
		max_installments: max_installments.to_s
	})
  end
end