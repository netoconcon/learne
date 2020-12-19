# frozen_string_literal: true

class Pm::Adapter::Card
  def initialize(order)
    @order = order
  end

  def payload
    {
        card_number: @order.credit_card_number.gsub(" ",""),
        card_holder_name: @order.credit_card_name,
        card_expiration_month: @order.credit_card_expiration_month,
        card_expiration_year: @order.credit_card_expiration_year,
        card_cvv: @order.credit_card_cvv
    }
  end
end
