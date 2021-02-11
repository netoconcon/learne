class Api::V1::OrdersController < Api::V1::BaseController
   def postback
    postback_body = request.raw_post
    signature = request.headers["X-Hub-Signature"]
    puts postback_body
    puts signature
    puts "Validando postback"
    if PagarMe::Postback.valid_request_signature?(postback_body, signature)
      puts "Postback autorizado"
      if postback_body
        ary = URI.decode_www_form(postback_body)
        payload = Hash[ary]
        order = Order.find(params[:id])
        postback_status = payload['current_status']
        # postback_old_status = payload['old_status']
        order.boleto_url = payload['boleto_url']
        order.boleto_bar_code = payload['boleto_bar_code']

        case postback_status
        when "paid"
          order.status = "completed"
          order.paid = true
        when "waiting_payment"
          order.status = "pending_payment"
        when "unpaid"
          order.status = "refused"
        when "canceled"
          order.status = "refused"
        else
          order.status = "refused"
        end
      end
        order.save
    else
      puts "Postback não autorizado"
    end
  end
end
