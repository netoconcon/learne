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
    order.user = user
    order.address = address
    order.price = kit.price + 1
    order.save!
  end

  def order
    @order ||= Order.new
  end

  def kit
    if Kit.nil?
     @kit ||= Kit.find(kit_id)
   end
  end

  private
    def order_attributes
      Order.attribute_names.index_with { |a| send(a) if respond_to?(a) }.compact
    end

    def user
      @user ||= begin
        user = User.find_by email: email
        user = User.create first_name: first_name, last_name: last_name, email: email, phone: phone, password: "123456" unless user.present?
        user
      end
    end

    # REPLIQUEI O METODO USER PARA CUSTOMER
    def customer
      @customer ||= begin
        customer = Customer.find_by email: email
        customer = Customer.create first_name: first_name, last_name: last_name, email: email, phone: phone
        customer
      end
    end

    def pagarme_customer
      # como pego nosso customer aqui
      pagarme_customer = PagarMe::Customer.create(
        name: @customer.first_name,
        email: @customer.email,
        type: 'individual',
        external_id: "#3311", #conferir o que é
        country: 'br',
        birthday: @customer.birthday,
        documents: [
        {type: "cpf", number: @customer.cpf}
        ],
        phone_numbers: [@customer.phone]
      )
    end

    def boleto_transaction
      # como eu pego a order aqui

      boleto = PagarMe::Transaction.new(
        amount:         , #TO DO get value in cents
        payment_method: 'boleto'
      )
      boleto.charge

      boleto_url = boleto.boleto_url     # => boleto's URL
      boleto_barcode =  boleto.boleto_barcode # => boleto's barcode

      # TO DO ENVIAR ESSAS INFOS POR MAILER
    end

    def cred_card_transaction
      # como eu pego a order aqui
      @order
      card = create_credit_card(@order)

      PagarMe::Transaction.new(
        amount:    , #TO DO get value in cents
        card_hash: card.id
      ).charge
    end

    def address
      @address ||= begin
        address = Address.find_by user_id: user.id, street: street, number: number, complement: complement, neighborhood: neighborhood, city: city, state: state, zipcode: zipcode
        address = Address.create user_id: user.id, street: street, number: number, complement: complement, neighborhood: neighborhood, city: city, state: state, zipcode: zipcode unless address.present?
        address
      end
    end

  def create_credit_card(order)
    # to save user credit card on pagarme and recieve a card hash
    # create a credit card on pagarme

    pagarme_card = PagarMe::Card.new({
      card_number: order.credit_card_number,
      card_holder_name: order.credit_card_name,
      card_expiration_month: order.credit_card_expiration_month,
      card_expiration_year: order.credit_card_expiration_year,
      card_cvv: order.credit_card_cvv
    })

    pagarme_card.create
  end
end
