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
      if @order.failed?
        flash[:notice] = "Compra recusada pelo #{transaction.refuse_reason}. Favor entrar em contato com seu banco"
        render :new
      else
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

    if @order.failed?
      flash[:notice] = "Sua compra foi recusada pelo #{@order.refused_reason}. Favor entrar em contato com o banco"
      render :new
    end
  end

  # def postback
  #   postback_body = request.raw_post
  #   signature = request.headers["X-Hub-Signature"]
  #   puts postback_body
  #   puts signature

  #   puts "Validando postback"

  #   if PagarMe::Postback.valid_request_signature?(postback_body, signature)
  #     puts "Postback autorizado"
  #     @order = Order.find_by(pagarme_transaction_id: params["id"])

  #     if params["payload"]
  #       ary = URI.decode_www_form(  params["payload"]  )
  #       payload = Hash[ary]

  #       @postback = Postback.create!(order: @order,
  #                                    pagarme_model: params["model"],
  #                                    pagarme_model_id: params["model_id"],
  #                                    headers: params["headers"],
  #                                    payload: payload,
  #                                    retries: params["retries"],
  #                                    pagarme_postback_id: params["id"]
  #                                    )

  #       current_status = payload["current_status"]
  #     else
  #       @postback = Postback.create!(order: @order,
  #                                    pagarme_model: params["object"],
  #                                    headers: request.headers,
  #                                    payload: params["transaction"],
  #                                    pagarme_postback_id: params["fingerprint"]
  #                                    )

  #       current_status = params["current_status"]
  #     end
  #     @order.change_status!(status: current_status)
  #   else
  #     puts "Postback não autorizado"
  #   end
  # end

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
