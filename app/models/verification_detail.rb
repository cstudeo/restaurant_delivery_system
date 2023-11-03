class VerificationDetail < ApplicationRecord
  belongs_to :carrier
  has_one_attached :card_picture
  has_one_attached :personal_picture
end
