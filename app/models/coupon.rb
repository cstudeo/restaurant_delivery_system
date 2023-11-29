class Coupon < ApplicationRecord

  validates :amount, numericality: { less_than_or_equal_to: 99999.99, message: "must be less than or equal to 99999.99" }

  def self.ransackable_attributes(auth_object = nil)
    ["code", "created_at", "id", "is_active", "updated_at", "used_by", "amount"]
  end
end
