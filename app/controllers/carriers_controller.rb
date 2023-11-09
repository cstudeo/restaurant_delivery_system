class CarriersController < ApplicationController
  layout 'carrier'
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def edit
  end


  def update
    current_user.update(update_params.except(:account_number))
    current_user.verification_detail.update(account_number: update_params[:acccount_number])
    redirect_to carriers_path
  end

  def update_availibilty
    if current_user.update(is_available: params[:is_available])
      render json: { success: true, message: "Availability status updated successfully" }
    else
      render json: { success: false, message: "Failed to update availability status" }
    end
  end

  def verification_details
    verification_details = VerificationDetail.new(verification_params)
    if verification_details.save!
      flash[:notice] = "details are saved"
    else
      flash[:notice] = "details are not saved"
    end
    redirect_to carriers_path
  end

  def verification_params
    params.permit(:account_number, :bank_name, :card_picture, :personal_picture).tap do |verification_params|
      verification_params[:carrier_id] = current_user.id
    end
  end

  def update_params
    params.permit(:first_name, :last_name, :phone_number, :account_number)
  end
end
