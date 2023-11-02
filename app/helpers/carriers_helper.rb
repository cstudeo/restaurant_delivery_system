module CarriersHelper
  def verification_details_present?
    current_user.verification_detail.present?
  end

  def carrier_profile_picture
    return '' if current_user.verification_detail.blank?
    current_user.verification_detail.personal_picture.key
  end
end
