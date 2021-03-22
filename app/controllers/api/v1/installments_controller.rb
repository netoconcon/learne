class Api::V1::InstallmentsController < Api::V1::BaseController
    def show
        installments = PagarMe::Transaction.calculate_installments(amount: params["amount"], interest_rate: 2.99, max_installments: 12)

        render json: installments
    end
  end
  