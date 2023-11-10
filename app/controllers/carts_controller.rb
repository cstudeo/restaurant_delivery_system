class CartsController < ApplicationController
    before_action :set_cart
  
    def update
        if @cart.coupon_applied
            render json: { error: 'Already applied' }, status: :unprocessable_entity
        else
            coupon = Coupon.find_by(code: params[:code])

            if coupon.nil?
                render json: { error: 'Invalid coupon' }, status: :unprocessable_entity
                return
            elsif !coupon.is_active
                render json: { error: 'Expired coupon' }, status: :unprocessable_entity
                return
            elsif coupon.amount > @cart[:total_amount]
                render json: { error: 'Not applicable, not enough items' }, status: :unprocessable_entity
                return
            end
            amount = @cart[:total_amount] - coupon.amount
            if @cart.update(total_amount: amount, coupon_applied: true)
                coupon.used_by = current_user.id
                render json: {  
                    new_total_amount: @cart[:total_amount],
                    message: 'Coupon Applied' 
                }

            else
                render json: { error: 'Something went wrong, try again' }, status: :unprocessable_entity
            end
        end
    end

    private

    def set_cart
        @cart = Cart.find(params[:id])
    end
end