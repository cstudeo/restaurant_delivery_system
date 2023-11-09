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
            # redirect_to order_path(@order)
            render json: {  
                total_amount: @order.total_amount,
                account_number: @carrier.verification_detail.account_number,
                order_id: @order.id
            }
        else
            render json: { error: 'Unable to process the order. Carriers not available. Please try again later.' }
            # flash[:alert] = "Unable to process the order. Please try again later."
            # redirect_to root_path
        end
    end

    def show
        @order = Order.find(params[:id])
    end

    def update
        @order = Order.find(params[:id])
      
        respond_to do |format|
          if @order.update(status: 1)
            OrderMailer.mail_customer(@order).deliver_now
            OrderMailer.mail_carrier(@order).deliver_now
      
            format.html { redirect_to order_path(@order) }
            format.json {
              render json: {
                message: 'Order status updated successfully',
                order_id: @order.id
              }
            }
          else
            format.html {
              flash[:alert] = 'Unable to process the order. Please try again later.'
              redirect_to root_path
            }
            format.json {
              render json: { error: 'Unable to process the order. Please try again later.' }, status: :unprocessable_entity
            }
          end
        end
    end

    def destroy 
        @order = Order.find(params[:id])
        @order.order_items.each do |order_item|
            order_item.update(order_id: nil, cart_id: current_cart.id)
        end
        if @order.destroy
            flash[:alert] = "Unable to process the payment. Please try again later."
            redirect_to root_path
        end
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
  