class OrdersController < ApplicationController
    before_action :authenticate_user!, only: [:create]
    before_action :set_cart, only: [:create]
    before_action :set_restaurant, only: [:create]
    before_action :set_customer, only: [:create]
    before_action :set_carrier, only: [:create]

    def create
        # store_location_for(:user, request.fullpath)
        # authenticate_user!
        # byebug

        @order = Order.new(
            customer: @customer,
            restaurant: @restaurant,
            carrier: @carrier,
            total_amount: @cart.total_amount
        )
        if @order.save
            @cart.order_items.each do |order_item|
              order_item.update(order_id: @order.id, cart_id: nil)
            end
            OrderMailer.new_order_mail(@order).deliver_now
            redirect_to order_path(@order)
        else
            flash[:alert] = "Unable to process the order. Please try again later."
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
  