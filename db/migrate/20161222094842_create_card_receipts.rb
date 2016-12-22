class CreateCardReceipts < ActiveRecord::Migration[5.0]
  def change
    create_table :card_receipts do |t|
      t.integer :number
      t.references :drawer_count, foreign_key: true
      t.decimal :charged_amount, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
