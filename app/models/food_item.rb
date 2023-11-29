class FoodItem < ApplicationRecord
  belongs_to :restaurant
  has_one_attached :picture
  has_many :order_items, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "price", "description", "restaurant_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["restaurant", "picture_attachment", "picture_blob"]
  end
end
