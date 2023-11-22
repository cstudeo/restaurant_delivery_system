class Restaurant < ApplicationRecord
  has_many :food_items, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["food_items"]
  end
end
