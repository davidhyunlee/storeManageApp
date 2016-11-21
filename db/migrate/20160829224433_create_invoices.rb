class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.references :customer, foreign_key: true
      t.references :user, foreign_key: true
      t.references :store, foreign_key: true
      t.decimal :total, precision: 10, scale: 2

      t.timestamps
    end
  end
end
