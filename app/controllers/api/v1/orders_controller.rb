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
        pagarme_id = pagarme_transaction_id.to_i

        # dealing with order
          order = Order.find_by(pagarme_id)
          order.status = payload.status
          order.save
        #
      end
    else
      puts "Postback não autorizado"
    end
  end
end
