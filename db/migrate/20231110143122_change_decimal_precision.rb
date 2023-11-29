class ChangeDecimalPrecision < ActiveRecord::Migration[7.0]
  def change
    change_column :carts, :total_amount, :decimal, precision: 7, scale: 2
    change_column :coupons, :amount, :decimal, precision: 7, scale: 2
    change_column :food_items, :price, :decimal, precision: 7, scale: 2
    change_column :order_items, :total, :decimal, precision: 7, scale: 2
    change_column :order_items, :unit_price, :decimal, precision: 7, scale: 2
    change_column :orders, :total_amount, :decimal, precision: 7, scale: 2
  end
end
