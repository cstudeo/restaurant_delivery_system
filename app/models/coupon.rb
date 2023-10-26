class Coupon < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["code", "created_at", "id", "is_active", "updated_at", "used_by", "amount"]
  end
end
