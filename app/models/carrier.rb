class Carrier < User
  has_many :orders
  has_one :verification_detail
  # has_many_attached :pictures

  scope :is_available, -> { where(is_available: true, is_verified: true) }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "daily_orders_count", "email", "encrypted_password", "first_name", "id", "is_available", "last_name", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "type", "updated_at"]
  end
end
