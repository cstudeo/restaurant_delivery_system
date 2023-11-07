class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :create_order_items, only: [:create], if: -> { controller_path == 'users/sessions' }

  private

  def after_sign_in_path_for(user)
    return carriers_path if user.instance_of? Carrier
    return admin_dashboard_path if user.instance_of? AdminUser
    return root_path if user.instance_of? Customer

    # stored_location = stored_location_for(user)

    # if stored_location
    #   stored_location
    # elsif user.instance_of?(Carrier)
    #   carriers_path
    # elsif user.instance_of?(AdminUser)
    #   admin_dashboard_path
    # else
    #   root_path
    # end
  end

  def create_order_items
    order_details = session[:order_details]
    if order_details
      order_details.each do |order_detail|
        food_item_id = order_detail["food_item_id"]
        quantity = order_detail["quantity"]
        current_cart.order_items.create(
          food_item_id: food_item_id,
          quantity: quantity
        )
      end
      session.delete(:order_details)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name email phone_number type])
  end
end
