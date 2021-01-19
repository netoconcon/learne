class Api::V1::OrdersController < Api::V1::BaseController
   def postback
    postback_body = request.raw_post
    signature = request.headers["X-Hub-Signature"]
    puts postback_body
    puts signature

    puts "Validando postback"

    if PagarMe::Postback.valid_request_signature?(postback_body, signature)
      puts "Postback autorizado"
      if params["payload"]
        ary = URI.decode_www_form(params["payload"])
        payload = Hash[ary]


        if params[:order_id].nil?
          order = Order.find(params[:id])
        else
          order = Order.find(params[:order_id])
        end

        

        postback_status = payload.status

        case postback_status
       
        when "paid"
          order.status = "completed"
        when "pending_payment"
          order.status = "pending_payment"
        when "unpaid"
          order.status = "refused"
        when "canceled"
          order.status = "refused"
        else
          order.status = "refused"
        end
      end

    else
      puts "Postback não autorizado"
    end
  end
end