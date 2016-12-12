class CreateSaleTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :sale_types do |t|
      t.string :name
      t.string :description
      t.boolean :tracked

      t.timestamps
    end
  end
end
