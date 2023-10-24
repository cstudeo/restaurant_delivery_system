class Order < ApplicationRecord
  belongs_to :restaurant

  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  belongs_to :carrier, class_name: 'User', foreign_key: 'carrier_id'
end
