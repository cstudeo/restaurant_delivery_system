class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.mail_customer.subject
  #
  def mail_customer(order)
    @order = order
    @customer = @order.customer

    mail(
      to: @customer.email,
      subject: "Order ##{order.id} confirmed"
    )
  end
  
  def mail_carrier(order)
    @order = order
    @carrier = @order.carrier

    mail(
      to: @carrier.email,
      subject: "Order ##{order.id} confirmed"
    )
  end
end
