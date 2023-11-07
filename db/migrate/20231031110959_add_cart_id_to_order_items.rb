class AddCartIdToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :order_items, :cart, foreign_key: true, null: true
  end
end
