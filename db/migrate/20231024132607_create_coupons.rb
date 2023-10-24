class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :code, null: false, default: ""
      t.boolean :is_active, null: false, default: true
      t.integer :used_by

      t.timestamps
    end
  end
end
