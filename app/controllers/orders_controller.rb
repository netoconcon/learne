class OrdersController < ApplicationController
layout "public"
skip_before_action :authenticate_user!

  def new
    @order = OrderForm.new
  end

  def create
    @order = OrderForm.new(order_params)
    if params[:card]
      @order.payment_method = true
    elsif params[:boleto]
      @order.payment_method = false
    end
    raise
    @order.save
    redirect_to(SellingPage.find_by(kit_id: @order.kit_id).confirmation_page)
  end

  private

  def order_params
    params.require(:order).permit(
        :installments,
        :price,
        :kit_id,
        :visit_id,
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
        :installments,
        :payment_method,
        :upsell_product
    )
  end
  
end
