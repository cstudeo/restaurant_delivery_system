class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :food_item


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "food_item_id", "id", "order_id", "quantity", "updated_at"]
  end
end
