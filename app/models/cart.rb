class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant, optional: true
  belongs_to :coupon, optional: true
  has_many :order_items
  before_create :set_total_amount

  def total_amount
    order_items.collect do |order_item|
      unit_price = order_item.unit_price || 0.to_d
      quantity = order_item.quantity || 0
    
      order_item.valid? ? unit_price * quantity : 0.to_d
    end.sum
  end

  private

  def set_total_amount
    self[:total_amount] = total_amount
  end
end
