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

        # dealing with order
          order = ORder.find(params[:id])
          order.status = payload.status
        #
      end
    else
      puts "Postback não autorizado"
    end
  end
end