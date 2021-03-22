# frozen_string_literal: true

class OrderForm
  include ActiveModel::Model
  include Address::Validation, User::Validation, Order::Validation
  #TO DO CHANGE LINE 5 FOR CUSTOMER AND CREATE A CUSTOMER VALIDATION

  delegate :model_name, :to_param, :persisted?, :id, to: :order
  delegate_missing_to :order

  attr_accessor(
      :installments,
      :kit_id,
      :visit_id,
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
      :boleto_cpf,
      :add_upsell_product,
      :amount,
      :kit_products
  )

  def save
    order.assign_attributes order_attributes
    order.customer = customer
    order.address = address
    order.shipment_amount = kit.shipment_cost
    if self.boleto_cpf.present?
      order.payment_method = :boleto
      self.installments = 1
      order.installments = 1
      order.products_amount = calc_amount
      self.products_amount = calc_amount
    else
      order.payment_method = :credit_card
      order.products_amount = calc_amount
      self.products_amount = calc_amount
    end

    order.cpf = cpf
    order.save!
    update_visit

    transaction = begin
                    if order.kit.single_payment?
                      Pm::Transaction.create(self)
                    else
                      Pm::Subscription.create(self)
                    end
                  end
    order.status = transaction.status == "refused" ? :refused : :completed
    order.refused_reason = transaction.refused_reason
    order.boleto_url = transaction.boleto_url
    order.boleto_bar_code = transaction.boleto_barcode
    if order.status == "completed" && order.payment_method
      order.paid = true
    end
    order.pagarme_transaction_id = transaction.id.to_i
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
        if customer.present?
          customer.update phone: phone, first_name: first_name, last_name: last_name
        else
          cpf = credit_card_cpf.present? ? credit_card_cpf : boleto_cpf
          customer = Customer.create first_name: first_name, last_name: last_name, email: email, cpf: cpf, phone: phone
        end
        customer
      end
    end

    def price
      @price ||= kit.price
    end

    def upsell_products
      @upsell_products ||= kit_products.present? ? kit_products.select { |_, value| value == "true" }.keys.map { |key| KitProduct.find(key) } : []
    end

    def calc_amount
      @amount ||= begin
                  value = (self.price * 100).to_i
                  value += ((self.upsell_products.map(&:price).sum) * 100).to_i if upsell_products.any?

                  installments_result = PagarMe::Transaction.calculate_installments({
                                                                                      amount: value,
                                                                                      interest_rate: 2.99,
                                                                                      max_installments: self.installments
                                                                                    })
                  BigDecimal(installments_result["installments"][self.installments.to_s]["amount"]) / 100
                end
    end

    def cpf
      credit_card_cpf.present? ? credit_card_cpf : boleto_cpf
      # credit_card_cpf || boleto_cpf
    end

    def pagarme_customer
      @pagarme_customer ||= Pm::Customer.create(customer)
    end

    def address
      @address ||= begin
        address = Address.find_by customer_id: customer.id, number: number, complement: complement, zipcode: zipcode
        address = Address.create customer_id: customer.id, street: street, number: number, complement: complement, neighborhood: neighborhood, city: city, state: state, zipcode: zipcode unless address.present?
        address
      end
    end

    def update_visit
      # Visit.find(visit_id).update order: order
    end
end
