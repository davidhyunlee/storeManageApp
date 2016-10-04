class CreateSimpleItems < ActiveRecord::Migration[5.0]
  def change
    create_table :simple_items do |t|
      t.references :store, foreign_key: true
      t.references :sellable, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
