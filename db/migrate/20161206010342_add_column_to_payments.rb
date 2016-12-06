class AddColumnToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :invoiced, :boolean, default: false
  end
end
