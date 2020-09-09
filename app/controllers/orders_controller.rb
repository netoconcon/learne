class OrdersController < ApplicationController
layout "public"

  after_create :send_email

  def new
    @order = OrderForm.new
  end

  def create
    @order = OrderForm.new(order_params)
    @order.save

    render "orders/thank_you"
  end

  private

  def order_params
    params.require(:order).permit(
        :installments,
        :price,
        :kit_id,
        :id,
        :phone,
        :email,
        :first_name,
        :last_name,
        :birthday,
        :street,
        :number,
        :complement,
        :neighborhood,
        :city,
        :state,
        :zipcode,
        :credit_card_number,
        :credit_card_name,
        :credit_card_cpf,
        :credit_card_expiration_month,
        :credit_card_expiration_year,
        :credit_card_cvv,
        :bank_slip_cpf,
        :installments
    )
  end

  def send_email
    OrderMailer.confirmation(self).deliver_now
  end
end
