class CreateFoodItems < ActiveRecord::Migration[7.0]
  def change
    create_table :food_items do |t|
      t.string :name, null: false, default: ""
      t.decimal :price, null: false
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
