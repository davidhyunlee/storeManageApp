class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.string :payment_type
      t.boolean :verified
      t.references :invoice, foreign_key: true
      t.references :store, foreign_key: true
      t.references :customer, foreign_key: true
      t.references :carrier, foreign_key: true
      t.references :user, foreign_key: true
      t.references :number, foreign_key: true

      t.timestamps
    end
  end
end
