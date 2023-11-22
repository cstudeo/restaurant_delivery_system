class Customer < User
  has_many :orders
  has_one :cart, foreign_key: 'user_id', dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "daily_orders_count", "email", "encrypted_password", "first_name", "id", "is_available", "last_name", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "type", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end
end
