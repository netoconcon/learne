class OrdersController < ApplicationController
  layout "public"
  skip_before_action :authenticate_user!
  before_action :get_infos, only: :thanks

  def new
    kit = Kit.find_by_slug(params[:kit_slug])
    @order = OrderForm.new(kit_id: kit.id)
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

  def get_infos
    order = Order.find(params[:format].to_i)
    unless order.pagarme_transaction_id.nil?
      transaction = PagarMe::Transaction.find_by_id(order.pagarme_transaction_id.to_i)
      order.boleto_url = transaction["boleto_url"]
      order.boleto_bar_code = transaction["boleto_barcode"]
      order.save
    end
  end


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
        :add_upsell_product,
        :insts,
        :amount
    )
  end

  def reduce_inventory(order)
    order.kit.kit_products.each do |kit_product|
      quantity = kit_product.quantity
      inventory_product = Inventory.find_by(product_id: kit_product.product_id)
      unless inventory_product.nil?
        inventory_product.update_attributes(quantity: inventory_product.quantity - quantity)
      end
    end
  end
end
