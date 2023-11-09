class AddBankNameToVerificationDetail < ActiveRecord::Migration[7.0]
  def change
    add_column :verification_details, :bank_name, :string
  end
end
