class CreateSellables < ActiveRecord::Migration[5.0]
  def change
    create_table :sellables do |t|
      t.references :category, foreign_key: true
      t.references :carrier, foreign_key: true
      t.string :description
      t.string :sku
      t.decimal :msrp
      t.decimal :taxable_price
      t.decimal :retail_price
      t.integer :estimated_on_hand
      t.boolean :taxable
      t.boolean :serialized

      t.timestamps
    end
  end
end
