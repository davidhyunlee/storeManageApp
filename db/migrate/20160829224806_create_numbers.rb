class CreateNumbers < ActiveRecord::Migration[5.0]
  def change
    create_table :numbers do |t|
      t.references :customer, foreign_key: true
      t.references :carrier, foreign_key: true
      t.string :number, null: false

      t.timestamps
    end
  end
end
