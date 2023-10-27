class FoodItem < ApplicationRecord
  belongs_to :restaurant
  has_one_attached :image


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "price", "restaurant_id", "updated_at"]
  end
end
