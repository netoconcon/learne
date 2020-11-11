class OrdersController < ApplicationController
layout "public"
skip_before_action :authenticate_user!

  def new
    @order = OrderForm.new
    tot_price
  end

  def create
    @order = OrderForm.new(order_params)
    if params[:card]
      @order.payment_method = true
    elsif params[:boleto]
      @order.payment_method = false
    end

    # begin
    if @order.save


        transaction = PagarMe::Transaction.find_by_id(@order.pagarme_transaction_id)
        @order.status = transaction.status
        @order.price = @order.price.to_i
        @order.refused_reason = transaction.refused_reason
        @order.boleto_url = transaction.boleto_url
        @order.boleto_bar_code = transaction.boleto_barcode
        @order.save

        # processing, authorized, paid, refunded, waiting_payment, pending_refund, refused
        if @order.status == "refused"
          flash[:notice] = "Recusada pelo #{transaction.refuse_reason}"
          render :new
        else
          redirect_to thanks_path(@order)
          flash[:notice] = "Sua compra foi aprovada"
        end

        # raise
        # redirect_to(SellingPage.find_by(kit_id: @order.kit_id).confirmation_page)
      else
        render :new
        flash[:notice] = "Existem erros no formulário"
      end
    # rescue => e
    #   puts e
    #   return nil
    # end

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
        :payment_method
    )
  end

end
