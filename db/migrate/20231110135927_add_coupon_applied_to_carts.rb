class AddCouponAppliedToCarts < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :coupon_applied, :boolean, default: false, null: false
  end
end
