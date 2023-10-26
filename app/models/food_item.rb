class FoodItem < ApplicationRecord
  belongs_to :restaurant


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "price", "restaurant_id", "updated_at"]
  end
end
