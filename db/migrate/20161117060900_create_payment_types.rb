class CreatePaymentTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_types do |t|
      t.string :name
      t.boolean :fee
      t.decimal :fee_amount
      t.references :carrier, foreign_key: true

      t.timestamps
    end
  end
end
