# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # after_action :transfer_session, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super do |user|
      if user_signed_in?
        transfer_session
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def transfer_session
    order_details = session[:order_details]

    if order_details
      order_details.each do |order_detail|
        food_item_id = order_detail["food_item_id"]
        quantity = order_detail["quantity"]
        restaurant_id = order_detail["restaurant_id"]
        current_cart = Cart.find_or_create_by(user_id: current_user.id, restaurant_id: restaurant_id)
        current_cart.order_items.create(
          food_item_id: food_item_id,
          quantity: quantity
        )
      end

      session.delete(:order_details)
    end
  end
end
