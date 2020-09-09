class Plan < ApplicationRecord

  def set_pagarme_plan
    # Create a Plan in Pagarme's DB
    plan = PagarMe::Plan.new({
      name: self.name,
      days: self.days,
      installments: self.installments,
      amount: self.amount,
      payment_methods: ['credit_card']
    })

    plan.create

    self.pagarme_id = plan.id
    self.save!

    raise "There was an error creating the plan" unless plan.id
  end
end
