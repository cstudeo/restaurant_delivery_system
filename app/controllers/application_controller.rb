class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :configure_permitted_parameters, if: :devise_controller?  

  private

  def customer_sign_up
    controller_path == 'users/registrations' && current_user.instance_of?(Customer)
  end

  def after_sign_in_path_for(user)
    return carriers_path if user.instance_of? Carrier
    return admin_dashboard_path if user.instance_of? AdminUser
    return root_path if user.instance_of? Customer
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name email phone_number type])
  end
end
