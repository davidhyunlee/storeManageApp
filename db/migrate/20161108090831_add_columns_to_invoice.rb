class AddColumnsToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :sales_tax, :decimal
    add_column :invoices, :subtotal, :decimal
  end
end
