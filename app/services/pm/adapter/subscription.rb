# frozen_string_literal: true

class Pm::Adapter::Subscription
  def initialize(order)
    @order = order
  end

  def payload
    {
        plan_id: pagarme_plan_id,
        payment_method: @order.payment_method ? 'credit_card' : 'boleto',
        card_id: @order.credit_card.id,
        # postback_url: ,
        customer: {
            name: @order.credit_card_name,
            document_number: @order.credit_card_cpf,
            email: @order.email,
            address: {
                street: @order.street.to_s,
                neighborhood: @order.neighborhood,
                zipcode: @order.zipcode,
                street_number: @order.number
            },
            phone: {
                ddd: @order.phone[1..2],
                number: @order.phone[5..-1].gsub("-","")
            },
        },
    }
  end

  private
    def pagarme_plan_id
      Plan.find(@order.kit.plan_id).pagarme_id
    end
end
