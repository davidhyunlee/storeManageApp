class AddColumnToPayment < ActiveRecord::Migration[5.0]
  def change
    add_reference :payments, :payment_type, foreign_key: true
    remove_column :payments, :payment_type
  end
end
