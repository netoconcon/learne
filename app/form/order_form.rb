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
    order.assign_attributes order_attributes
    order.customer = customer
    order.address = address
    order.price = kit.price.to_i + 1

    pagarme_customer # create customer on pagarme's db

    # if order.plan
      # create_subscription
    # else

      unless self.credit_card_cpf.empty?
        raise
        cred_card_transaction
      else
        boleto_transaction
      end
    # end
    order.save!
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

    def pagarme_customer
      customer_phone = phone.gsub("(","").gsub(")","").gsub("-","").gsub(" ","")
      customer_cpf = credit_card_cpf.gsub(".","").gsub("-","") unless credit_card_cpf.nil?
      customer_cpf = bank_slip_cpf .gsub(".","").gsub("-","") unless bank_slip_cpf.nil?

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
          amount: 100,
          payment_method: "boleto",
          # card_number: order.credit_card_number.gsub(" ",""),
          # card_holder_name: order.credit_card_name,
          # card_expiration_date: credit_card_expiration_month + credit_card_expiration_year,
          # card_cvv: order.credit_card_cvv,
          postback_url: "http://requestb.in/pkt7pgpk",
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
            name: "Trinity Moss",
            address: {
              country: "br",
              state: "sp",
              city: "Cotia",
              neighborhood: "Rio Cotia",
              street: "Rua Matrix",
              street_number: "9999",
              zipcode: "06714360"
            }
          },
          shipping: {
            name: "Neo Reeves",
            fee: 1000,
            delivery_date: "2000-12-21",
            expedited: true,
            address: {
              country: "br",
              state: "sp",
              city: "Cotia",
              neighborhood: "Rio Cotia",
              street: "Rua Matrix",
              street_number: "9999",
              zipcode: "06714360"
            }
          },
          items: [
            {
              id: "r123",
              title: "Red pill",
              unit_price: 10000,
              quantity: 1,
              tangible: true
            },
            {
              id: "b123",
              title: "Blue pill",
              unit_price: 10000,
              quantity: 1,
              tangible: true
            }

          ]
        })
        raise
        transaction.charge
      end

      boleto_url = transaction.boleto_url     # => boleto's URL
      boleto_barcode =  transaction.boleto_barcode # => boleto's barcode

      # TODO ENVIAR ESSAS INFOS POR MAILER
    end

    def cred_card_transaction
      order = self
      card = create_credit_card(order)

      card_number = order.credit_card_number.gsub(" ","")

      ActiveRecord::Base.transaction do
        transaction  = PagarMe::Transaction.new({
          amount: 100,
          payment_method: "credit_card",
          card_number: order.credit_card_number.gsub(" ",""),
          card_holder_name: order.credit_card_name,
          card_expiration_date: credit_card_expiration_month + credit_card_expiration_year,
          card_cvv: order.credit_card_cvv,
          postback_url: "http://requestb.in/pkt7pgpk",
          customer: {
            external_id: order.customer.id.to_s,
            name: order.credit_card_name,
            type: "individual",
            country: "br",
            email: order.email,
            documents: [
              {
                type: "cpf",
                number: order.credit_card_cpf.gsub(".","").gsub("-","")

              }
            ],
            phone_numbers: ["+55" + order.phone.gsub("(","").gsub(")","").gsub(" ","").gsub("-","")],
            # birthday: order.customer.birthday.to_s
          },
          billing: {
            name: "Trinity Moss",
            address: {
              country: "br",
              state: "sp",
              city: "Cotia",
              neighborhood: "Rio Cotia",
              street: "Rua Matrix",
              street_number: "9999",
              zipcode: "06714360"
            }
          },
          shipping: {
            name: "Neo Reeves",
            fee: 1000,
            delivery_date: "2000-12-21",
            expedited: true,
            address: {
              country: "br",
              state: "sp",
              city: "Cotia",
              neighborhood: "Rio Cotia",
              street: "Rua Matrix",
              street_number: "9999",
              zipcode: "06714360"
            }
          },
          items: [
            {
              id: "r123",
              title: "Red pill",
              unit_price: 10000,
              quantity: 1,
              tangible: true
            },
            {
              id: "b123",
              title: "Blue pill",
              unit_price: 10000,
              quantity: 1,
              tangible: true
            }

          ]
        })
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

    ActiveRecord::Base.transaction do
      subscription = PagarMe::Subscription.new({
        plan_id: plan,
        payment_method: 'credit_card',
        card_id: card.id,
        # postback_url: ,
        customer: {
            name: credit_card_name,
            document_number: credit_card_cpf,
            email: current_user.email,
            address: {
                street: current_user.street,
                neighborhood: current_user.neighborhood,
                zipcode: current_user.zipcode,
                street_number: current_user.street_number
            },
            phone: {
                ddd: current_user.phone_ddd,
                number: current_user.phone_number
            },
        },
      })
      subscription.create
    end
  end
end
