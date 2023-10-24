class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.decimal :total_amount
      t.references :customer, null: false, foreign_key: { to_table: :users }
      t.references :carrier, null: false, foreign_key: { to_table: :users }
      t.integer :status
      t.datetime :picked_up_at

      t.timestamps
    end
  end
end
