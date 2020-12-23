module InterestHelper
  def order_interest(order)
  	amount = order.kit.amount_cents + order.kit.shipment_cost_cents
  	max_installments = order.kit.maximum_installments

		installments_result = PagarMe::Transaction.calculate_installments({
		    amount: amount.to_i,
		    interest_rate: 2.99,
		    max_installments: max_installments.to_s
		})

		# isso daqui vai retornar uma HASH, por exemplo para max installments = 3

# 		{
#     "installments": {
#         "1": {
#             "installment": 1,
#             "amount": 10000,
#             "installment_amount": 10000
#         },
#         "2": {
#             "installment": 2,
#             "amount": 10598,
#             "installment_amount": 5299
#         },
#         "3": {
#             "installment": 3,
#             "amount": 10897,
#             "installment_amount": 3632
#         }
#     }
# }
  end
end