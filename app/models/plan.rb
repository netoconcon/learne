class Plan < ApplicationRecord

  belongs_to :kit, optional: true

  def set_pagarme_plan
    # Create a Plan in Pagarme's DB
    payment_type = set_payment_type(self.payment_methods)

    plan = PagarMe::Plan.new({
      name: self.name,
      days: self.days,
      installments: self.installments,
      amount: self.price,
      payment_methods: payment_type
    })

    plan.create

    self.pagarme_id = plan.id
    self.save!

    raise "There was an error creating the plan" unless plan.id
  end

  def set_payment_type(method)
    case method
      when 'boleto'
        ['boleto']
      when 'cartão'
        ['credit_card']
      when 'boleto e cartão'
        ["boleto", "credit_card"]
    end
  end
end
