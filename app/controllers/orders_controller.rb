class OrdersController < ApplicationController
layout "public"
skip_before_action :authenticate_user!

  def new
    @order = OrderForm.new
  end

  def create
    flash[:notice] = "Estamos processando sua compra"
    @order = OrderForm.new(order_params)
    if params[:card]
      @order.payment_method = true
    elsif params[:boleto]
      @order.payment_method = false
    end

    if @order.save
      if @order.refused?
        flash[:notice] = "Compra recusada pelo #{transaction.refuse_reason}. Favor entrar em contato com seu banco"
        render :new
      else
        reduce_inventory(@order)
        redirect_to thanks_path(@order)
        flash[:notice] = "Sua compra foi aprovada"
      end
    else
      render :new
      flash[:notice] = "Existem erros no formulário"
    end
  end

  def thanks
    @order = Order.find(params["format"])

    if @order.refused?
      flash[:notice] = "Sua compra foi recusada pelo #{@order.refused_reason}. Favor entrar em contato com o banco"
      render :new
    end
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
  
  def reduce_inventory(order)
    order.kit.kit_products.each do |kit_product|
      quantity = kit_product.quantity
      inventory_product = Inventory.find_by(product_id: kit_product.product_id)
      inventory_product.update_attributes(quantity: inventory_product.quantity - quantity)
    end
  end
end
