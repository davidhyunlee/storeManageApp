class AddColumnToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :note, :string
  end
end
