class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.new_order_mail.subject
  #
  def new_order_mail(order)
    @order = order
    @customer = @order.customer

    mail(
      to: @customer.email,
      subject: "Order #{order.id} confirmed"
    )
  end
end
