class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:create, :new]
  before_action :set_restaurant, only: [:create]
  before_action :set_customer, only: [:create]
  before_action :set_carrier, only: [:create]
  # after_action :initialize_payment, only: [:create]

  def new
    @cart.coupon_applied = @cart.coupon_applied || false
    coupon_amount = @cart.coupon && @cart.total_amount > 0 && (@cart.total_amount - @cart.coupon&.amount) > 0 ? @cart.coupon&.amount : 0
    @coupon_message = coupon_amount > 0 ? 'Your previous coupon is still applied for this cart' : ''
    @cart[:total_amount] = @cart.total_amount - coupon_amount
    @cart.save
  end

  def create
    @order = Order.new(
      customer: @customer,
      restaurant: @restaurant,
      carrier: @carrier,
      total_amount: @cart[:total_amount]
    )
    if @order.save
      @cart.order_items.each do |order_item|
        order_item.update(order_id: @order.id, cart_id: nil)
      end
      @cart.destroy
      initialize_payment
    else
      render json: { error: 'Unable to process the order. Carriers not available. Please try again later.' }
    end
  end

  def initialize_payment
    secret_key = Rails.application.credentials.paystack.secret_key
    paystack_url = URI.parse('https://api.paystack.co/transaction/initialize')
    app_url = Rails.application.credentials.app_url
    http = Net::HTTP.new(paystack_url.host, paystack_url.port)
    http.use_ssl = true
    email = @customer.email
    total_amount = order_amount_with_extra_charges.to_f.round() * 100
    carrier_account = @carrier.verification_detail.account_number

    headers = {
      'Authorization' => "Bearer #{secret_key}",
      'Content-Type' => 'application/json'
    }

    data = {
      'email' => 'umerb0004@gmail.com',
      'amount' => total_amount,
      'subaccount' => carrier_account,
      'currency' => 'NGN',
      'callback_url' => "#{app_url}/orders/#{@order.id}/confirm_order"
    }

    byebug

    request = Net::HTTP::Post.new(paystack_url.path, headers)
    request.body = data.to_json

    response = http.request(request)
    response = JSON.parse(response.body)

    if response["status"]
      authorization_url = response["data"]["authorization_url"]
      reference = response["data"]["reference"]
      redirect_to authorization_url, allow_other_host: true
    end
  end

  def order_amount_with_extra_charges
    total_amount = @order.total_amount.to_f
    delivery_charges = 400
    food_charges = (1.7 * @order.total_amount / 100 )
    service_fee = 100

    total_amount + delivery_charges + food_charges + service_fee
  end


  def confirm_order
    @order = Order.find_by(id: params[:id])
    secret_key = Rails.application.credentials.paystack.secret_key
    transaction_reference = params[:reference]
    url = URI.parse("https://api.paystack.co/transaction/verify/#{transaction_reference}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    headers = {
      'Authorization' => "Bearer #{secret_key}"
    }

    request = Net::HTTP::Get.new(url.path, headers)

    response = http.request(request)
    response_body = JSON.parse(response.body)

    if response_body["status"]
      @order.update(status: "paid")
      OrderMailer.mail_customer(@order).deliver_now
      OrderMailer.mail_carrier(@order).deliver_now
      redirect_to root_path
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def set_cart
    @cart = current_cart
  end

  def set_restaurant
    @restaurant = @cart.restaurant
  end

  def set_customer
    @customer = current_user
  end

  def set_carrier
    @carrier = eligible_carriers
  end
end
