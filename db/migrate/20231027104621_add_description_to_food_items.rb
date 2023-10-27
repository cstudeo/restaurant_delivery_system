class AddDescriptionToFoodItems < ActiveRecord::Migration[7.0]
  def change
    add_column :food_items, :description, :text
  end
end
