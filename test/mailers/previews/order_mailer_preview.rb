# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/new_order_mail
  def new_order_mail(order)
    @order = order

    mail(
      to: @order.customer.email,
      subject: "Order #{order.id} confirmed"
    )
  end

end
