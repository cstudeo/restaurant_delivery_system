class CreateVerificationDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :verification_details do |t|
      t.string :account_number
      t.references :carrier, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
