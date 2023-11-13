class OrderItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :food_item
  belongs_to :order, optional: true
  before_save :set_unit_price
  before_save :set_total

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "food_item_id", "id", "order_id", "quantity", "updated_at"]
  end

  def unit_price    
    persisted? ? self[:unit_price] : food_item.price
  end

  def total
    return 0.to_d if unit_price.nil? || quantity.nil?

    unit_price * quantity
  end

  private

  def set_unit_price
    self[:unit_price] = unit_price
  end

  def set_total
    self[:total] = total
  end
end
