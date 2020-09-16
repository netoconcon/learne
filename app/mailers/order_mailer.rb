class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.confirmation.subject
  #
  def confirmation
    @customer = Customer.last

    mail(to: @customer.email, subject: 'Ordem feito')
  end
end
