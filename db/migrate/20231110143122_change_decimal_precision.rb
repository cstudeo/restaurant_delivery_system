class ChangeDecimalPrecision < ActiveRecord::Migration[7.0]
  def change
    change_column :carts, :total_amount, :integer
    change_column :coupons, :amount, :integer
    change_column :food_items, :price, :integer
    change_column :order_items, :total, :integer
    change_column :order_items, :unit_price, :integer
    change_column :orders, :total_amount, :integer
  end
end
