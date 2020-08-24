# frozen_string_literal: true

class OrderForm
  include ActiveModel::Model
  include Address::Validation, User::Validation, Order::Validation

  delegate :model_name, :to_param, :persisted?, to: :order
  delegate_missing_to :order

  attr_accessor(
      :installments,
      :price,
      :kit,
      :id,
      :phone,
      :email,
      :first_name,
      :last_name,
      :cpf,
      :birthday,
      :street,
      :number,
      :complement,
      :neighborhood,
      :city,
      :state,
      :zipcode,
  )

  def save
    order.assign_attributes order_attributes
    order.user = user
    order.address = address
    order.save!
  end

  def order
    @order ||= Order.new
  end

  private
    def order_attributes
      Order.attribute_names.index_with { |a| send(a) if respond_to?(a) }.compact
    end

    def user
      @user ||= User.find_or_create_by first_name: first_name, last_name: last_name, email: email, phone: phone, cpf: cpf, zipcode: zipcode
    end

    def address
      @address ||= Address.find_or_create_by user: user, street: street, number: number, complement: complement, neighborhood: neighborhood, city: city, state: state, zipcode: zipcode
    end
end
