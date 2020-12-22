# frozen_string_literal: true

class Pm::Adapter::Transaction
  def initialize(order)
    @order = order
  end

  def payload
    @payload = {
        amount: @order.price.to_i,
        installments: @order.insts.to_i,
        postback_url: "http://www.pay.learne.com.br/orders/#{@order.id}/postback/",
        payment_method: @order.payment_method ? "credit_card" : "boleto",
        customer: {
            external_id: @order.customer.id.to_s,
            name: @order.customer.first_name + ' ' + @order.customer.last_name,
            type: "individual",
            country: "br",
            email: @order.customer.email,
            documents: [
                {
                    type: "cpf",
                    number: @order.cpf.gsub(".","").gsub("-","")

                }
            ],
            phone_numbers: ["+55" + @order.customer.phone.gsub("(","").gsub(")","").gsub(" ","").gsub("-","")],
        },
        billing: {
            name: @order.customer.first_name + " " + @order.customer.last_name,
            address: {
                country: "br",
                state: @order.address.state,
                city: @order.address.city,
                neighborhood: @order.address.neighborhood,
                street: @order.address.street,
                street_number: @order.address.number.to_s,
                zipcode: @order.address.zipcode.gsub("-","")
            }
        },
        shipping: {
            name: @order.customer.first_name + " " + @order.customer.last_name,
            fee: @order.kit.shipment_cost_cents,
            delivery_date: "2000-12-21",
            expedited: true,
            address: {
                country: "br",
                state: @order.address.state,
                city: @order.address.city,
                neighborhood: @order.address.neighborhood,
                street: @order.address.street.to_s,
                street_number: @order.address.number.to_s,
                zipcode: @order.address.zipcode.gsub("-","")
            }
        },
        items: order_items
    }

    if @order.payment_method
      @payload[:card_number] = @order.credit_card_number.gsub(" ","")
      @payload[:card_holder_name] = @order.credit_card_name
      @payload[:card_expiration_date] = @order.credit_card_expiration_month + @order.credit_card_expiration_year
      @payload[:card_cvv] = @order.credit_card_cvv
    end

    @payload
  end

  private
    def order_items
      @order.kit.kit_products.map do |order_product|
        {
            id: order_product.product_id.to_s,
            title: order_product.product.name,
            unit_price: order_product.price_cents.to_i,
            quantity: order_product.quantity,
            tangible: true
        }
      end
    end
end
