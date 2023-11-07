class ChangeOrderItemsOrderIdNullConstraint < ActiveRecord::Migration[7.0]
  def change
    change_column :order_items, :order_id, :bigint, null: true
  end
end
