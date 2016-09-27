class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.references :invoice, foreign_key: true
      t.references :sellable, foreign_key: true
      t.references :serialized_item, foreign_key: true
      t.integer :quantity
      t.decimal :sold_price

      t.timestamps
    end
  end
end
