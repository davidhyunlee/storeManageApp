class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :code
      t.string :name
      t.string :description
      t.decimal :price, precision: 10, scale: 2
      t.references :carrier, foreign_key: true

      t.timestamps
    end
  end
end
