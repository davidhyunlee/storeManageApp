class CreateSellables < ActiveRecord::Migration[5.0]
  def change
    create_table :sellables do |t|
      t.references :category, foreign_key: true
      t.references :carrier, foreign_key: true
      t.string :name
      t.string :description
      t.string :sku
      t.string :manufacturer
      t.string :model
      t.string :color
      t.decimal :msrp, precision: 10, scale: 2
      t.decimal :taxable_price, precision: 10, scale: 2
      t.decimal :retail_price, precision: 10, scale: 2
      t.integer :estimated_on_hand
      t.boolean :taxable
      t.boolean :serialized

      t.timestamps
    end
  end
end
