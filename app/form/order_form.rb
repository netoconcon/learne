# frozen_string_literal: true

class OrderForm
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
    order.price = kit.price + 1


    #START PAGARME ACTION TO REFACTOR LATER
    # TO DO CHECK IF CRED CARD OR BOLETO

    # pagarme_customer # create customer on pagarme's db
    cred_card_transaction
    raise

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
      pagarme_customer = PagarMe::Customer.create(
        name: customer.first_name + ' ' + customer.last_name,
        email: customer.email,
        type: 'individual',
        # external_id: "#3311", #conferir o que é
        country: 'br',
        # birthday: birthday.to_s unless customer.birthday.nil?,
        documents: [
        {"type": "cpf", "number": credit_card_cpf.gsub(".","").gsub("-","")}
        ],
        phone_numbers: ["+55#{phone}"]
      )
    end


    def boleto_transaction
      boleto = PagarMe::Transaction.new(
        amount:  order.amount, #TO DO get value in cents
        payment_method: 'boleto'
      )
      boleto.charge

      boleto_url = boleto.boleto_url     # => boleto's URL
      boleto_barcode =  boleto.boleto_barcode # => boleto's barcode

      # TO DO ENVIAR ESSAS INFOS POR MAILER
    end

    def cred_card_transaction
      card = create_credit_card(@order)

      PagarMe::Transaction.new(
        amount: 1, #TO DO get value in cents
        card_hash: card.id,
        installments: 1,
        payment_method: 'credit_card',
        # postback_url
        customer: {
          # "external_id": "#3311",
          "name": "Morpheus Fishburne",
          "type": "individual",
          "country": "br",
          "email": "mopheus@nabucodonozor.com",
          "documents": [
            {
              "type": "cpf",
              "number": "00000000000"
            }
          ],
          "phone_numbers": ["+5511999998888"],
          "birthday": "1965-01-01"
        },
      ).charge
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
