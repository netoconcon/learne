class Payment < ApplicationRecord

  def create_credit_card
    # to save user credit card on pagarme and recieve a card hash

    dates = params[:expiry].split("/")

    # create a credit card on pagarme
    pagarme_card = PagarMe::Card.new({
      card_number: params[:number],
      card_holder_name: params[:name],
      card_expiration_month: dates.first,
      card_expiration_year: dates.last,
      card_cvv: params[:cvv]
    })

    pagarme_card.create

    # Cria um cartão no nosso banco de dados, atrelado ao nosso usuário


  end

  def credit_card_transaction
    # add a new credit card transaction on pagarme

    PagarMe::Transaction.new(
      amount:    1000,      # in cents
      card_hash: card_hash  # how to get a card hash: docs.pagar.me/capturing-card-data
    ).charge
  end



end
