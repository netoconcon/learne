# frozen_string_literal: true

class OrderForm
  require 'pagarme'
  include ActiveModel::Model
  include Address::Validation, User::Validation, Order::Validation
  #TO DO CHANGE LINE 5 FOR CUSTOMER AND CREATE A CUSTOMER VALIDATION

  delegate :model_name, :to_param, :persisted?, to: :order
  delegate_missing_to :order

  attr_accessor(
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
      :installments,
      :bank_slip_cpf
  )

  def save
    total_price = []
    order.assign_attributes order_attributes
    order.customer = customer
    order.address = address
    KitProduct.where(kit_id: order.kit_id).each do |order|
      total_price << order.price.to_i
    end
    order.price = total_price.sum
    # order.price = KitProduct.where(kit_id: order.kit_id).price.to_i + 1
    pagarme_customer # create customer on pagarme's db

    if order.kit.payment_type == "single"
      if self.payment_method
        transaction = cred_card_transaction
      else
        transaction = boleto_transaction

        transaction_infos = PagarMe::Transaction.find_by_id(transaction.id)

        order.boleto_url = transaction_infos.boleto_url     # => boleto's URL
        order.boleto_bar_code =  transaction_infos.boleto_barcode # => boleto's barcode
      end
    else
      transaction = create_subscription
    end

    order.pagarme_transaction_id = transaction.id

    if order.save
      update_visit
    end
  end

  def order
    @order ||= Order.new
  end

  def kit
    unless kit_id.nil?
     @kit ||= Kit.find(kit_id)
   end
  end

  private
    def order_attributes
      Order.attribute_names.index_with { |a| send(a) if respond_to?(a) }.compact
    end

    def customer
      @customer ||= begin
        customer = Customer.find_by email: email
        customer = Customer.create first_name: first_name, last_name: last_name, email: email, cpf: credit_card_cpf , phone: phone unless customer.present?
        customer
      end
    end

    def set_price
      @order.kit.kit_products.first.price_cents + @order.kit.shipment_cost_cents
    end

    def pagarme_customer
      customer_phone = phone.gsub("(","").gsub(")","").gsub("-","").gsub(" ","")
      customer_cpf = credit_card_cpf.gsub(".","").gsub("-","") unless credit_card_cpf.empty?
      customer_cpf = bank_slip_cpf .gsub(".","").gsub("-","") unless bank_slip_cpf.empty?

      pagarme_customer = PagarMe::Customer.create(
        name: customer.first_name + ' ' + customer.last_name,
        email: customer.email,
        type: 'individual',
        external_id: customer.id.to_s,
        country: 'br',
        # birthday: birthday.to_s unless customer.birthday.nil?,
        documents: [
        {"type": "cpf", "number": customer_cpf}
        ],
        phone_numbers: ["+55#{customer_phone}"]
      )
    end


    def boleto_transaction
      ActiveRecord::Base.transaction do
        transaction  = PagarMe::Transaction.new({
          amount: set_price,
          installments: order.installments.to_i,
          postback_url: "http://requestb.in/pkt7pgpk",
          payment_method: "boleto",
          # card_number: order.credit_card_number.gsub(" ",""),
          # card_holder_name: order.credit_card_name,
          # card_expiration_date: credit_card_expiration_month + credit_card_expiration_year,
          # card_cvv: order.credit_card_cvv,
          customer: {
            external_id: order.customer.id.to_s,
            name: self.first_name + ' ' + self.last_name,
            type: "individual",
            country: "br",
            email: self.email,
            documents: [
              {
                type: "cpf",
                number: self.bank_slip_cpf.gsub(".","").gsub("-","")

              }
            ],
            phone_numbers: ["+55" + self.phone.gsub("(","").gsub(")","").gsub(" ","").gsub("-","")],
            # birthday: order.customer.birthday.to_s
          },
          billing: {
            name: self.first_name + " " + self.last_name,
            address: {
              country: "br",
              state: self.state,
              city: self.city,
              neighborhood: self.neighborhood,
              street: self.street,
              street_number: self.number.to_s,
              zipcode: self.zipcode.gsub("-","")
            }
          },
          shipping: {
            name: self.first_name + " " + self.last_name,
            fee: self.kit.shipment_cost_cents,
            delivery_date: "2000-12-21",
            expedited: true,
            address: {
              country: "br",
              state: self.state,
              city: self.city,
              neighborhood: self.neighborhood,
              street: self.street.to_s,
              street_number: self.to_s,
              zipcode: self.zipcode.gsub("-","")
            }
          },
          items: []
        })

        order.kit.kit_products.each do |order_product|
          transaction.items.push({
              id: order_product.product_id.to_s,
              title: order_product.product.name,
              unit_price: order_product.price_cents,
              quantity: order_product.quantity,
              tangible: true
            })
        end
        transaction.charge
      end

    end

    def cred_card_transaction
      card = create_credit_card(order)

      card_number = self.credit_card_number.gsub(" ","")

      ActiveRecord::Base.transaction do
        transaction  = PagarMe::Transaction.new({
          amount: set_price,
          installments: self.installments.to_i,
          payment_method: "credit_card",
          card_number: self.credit_card_number.gsub(" ",""),
          card_holder_name: self.credit_card_name,
          card_expiration_date: credit_card_expiration_month + credit_card_expiration_year,
          card_cvv: self.credit_card_cvv,
          postback_url: "http://requestb.in/pkt7pgpk",
          customer: {
            external_id: self.customer.id.to_s,
            name: self.credit_card_name,
            type: "individual",
            country: "br",
            email: self.email,
            documents: [
              {
                type: "cpf",
                number: self.credit_card_cpf.gsub(".","").gsub("-","")

              }
            ],
            phone_numbers: ["+55" + self.phone.gsub("(","").gsub(")","").gsub(" ","").gsub("-","")],
            # birthday: order.customer.birthday.to_s
          },
          billing: {
            name: self.first_name + " " + self.last_name,
            address: {
              country: "br",
              state: self.state,
              city: self.city,
              neighborhood: self.neighborhood,
              street: self.street.to_s,
              street_number: self.number.to_s,
              zipcode: self.zipcode.gsub("-","")
            }
          },
          shipping: {
            name: self.first_name + " " + self.last_name,
            fee: self.kit.shipment_cost_cents,
            delivery_date: "2000-12-21",
            expedited: true,
            address: {
              country: "br",
              state: self.state,
              city: self.city,
              neighborhood: self.neighborhood,
              street: self.street.to_s,
              street_number: self.number.to_s,
              zipcode: self.zipcode.gsub("-","")
            }
          },
          items: []
        })

        order.kit.kit_products.each do |order_product|
          transaction.items.push({
              id: order_product.product_id.to_s,
              title: order_product.product.name,
              unit_price: order_product.price_cents,
              quantity: order_product.quantity,
              tangible: true
            })
        end
        transaction.charge
      end
    end

    def address
      @address ||= begin
        address = Address.find_by customer_id: customer.id, street: street, number: number, complement: complement, neighborhood: neighborhood, city: city, state: state, zipcode: zipcode
        address = Address.create customer_id: customer.id, street: street, number: number, complement: complement, neighborhood: neighborhood, city: city, state: state, zipcode: zipcode unless address.present?
        address
      end
    end

    def create_credit_card(order)
      # to save user credit card on pagarme and recieve a card hash
      # create a credit card on pagarme
      pagarme_card = PagarMe::Card.new({
        card_number: credit_card_number.gsub(" ",""),
        card_holder_name: credit_card_name,
        card_expiration_month: credit_card_expiration_month,
        card_expiration_year: credit_card_expiration_year,
        card_cvv: credit_card_cvv
      })

      pagarme_card.create
    end

    def create_subscription

      # get infos we need to subscription
      customer = pagarme_customer
      card = create_credit_card(@order)
      # TO DO get plan on order.product
      plan = Plan.find(order.kit.plan_id)
      plan_id = PagarMe::Plan.find(plan.pagarme_id)

      if self.payment_method
        transaction_type = 'credit_card'
      else
        transaction_type = 'boleto'
      end

      ActiveRecord::Base.transaction do
        subscription = PagarMe::Subscription.new({
          plan_id: plan.pagarme_id.to_i,
          payment_method: transaction_type,
          card_id: card.id,
          # postback_url: ,
          customer: {
              name: credit_card_name,
              document_number: credit_card_cpf,
              email: self.email,
              address: {
                  street: self.street.to_s,
                  neighborhood: self.neighborhood,
                  zipcode: self.zipcode,
                  street_number: self.number
              },
              phone: {
                  ddd: self.phone[1..2],
                  number: self.phone[5..-1].gsub("-","")
              },
          },
        })
        subscription.create
      end
    end

    def update_visit
      Visit.find(visit_id).update order_id: order.id
    end
end
