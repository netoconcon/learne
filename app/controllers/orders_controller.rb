class OrdersController < ApplicationController
  layout "public"

  def new
    @order = OrderForm.new
  end

  def create
    @order = OrderForm.new(order_params)
  end

  private

  def order_params
    params.require(:kit).permit(
        :installments,
        :price,
        :kit,
        :id,
        :phone,
        :email,
        :first_name,
        :last_name,
        :cpf,
        :birthday,
        :street,
        :number,
        :complement,
        :neighborhood,
        :city,
        :state,
        :zipcode,
    )
  end
end
