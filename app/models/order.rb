class Order < ApplicationRecord
  has_many :order_items
  belongs_to :restaurant
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  belongs_to :carrier, class_name: 'User', foreign_key: 'carrier_id'

  enum status: { unpaid: 0, paid: 1 }, _default: :unpaid

  def self.ransackable_attributes(auth_object = nil)
    ["carrier_id", "created_at", "customer_id", "id", "picked_up_at", "restaurant_id", "status", "total_amount", "updated_at"]
  end
end
