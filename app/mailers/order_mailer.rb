class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.confirmation.subject
  #
  def confirmation
    @order = Order.last
    @customer = @order.customer

    mail(to: @customer.email, subject: 'Seu pedido foi confirmado')
  end
end
