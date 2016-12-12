class AddEmployeePaymentVerificationColumnToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :employee_verified, :boolean, default: false
    add_column :payments, :verifying_user, :integer
  end
end
