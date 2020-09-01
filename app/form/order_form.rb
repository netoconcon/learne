# frozen_string_literal: true

class OrderForm
  include ActiveModel::Model
  include Address::Validation, User::Validation, Order::Validation

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

    def address
      @address ||= begin
        address = Address.find_by user_id: user.id, street: street, number: number, complement: complement, neighborhood: neighborhood, city: city, state: state, zipcode: zipcode
        address = Address.create user_id: user.id, street: street, number: number, complement: complement, neighborhood: neighborhood, city: city, state: state, zipcode: zipcode unless address.present?
        address

      end
    end
end
