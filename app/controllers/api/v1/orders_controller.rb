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



# processing, waiting_retry, pending_retry, failed, success

  # enum status: {
  #     pending_payment: 0,   # User completed the checkout, we must wait confirmation
  #     completed: 1,         # Everything went fine.
  #     refused: 2,            # Unfortunately something went wrong
  # }