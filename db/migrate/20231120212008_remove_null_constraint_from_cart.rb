class RemoveNullConstraintFromCart < ActiveRecord::Migration[7.0]
  def change
    change_column :carts, :restaurant_id, :integer, null: true
  end
end
