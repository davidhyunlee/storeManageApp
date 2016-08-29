class CreateSerializedItems < ActiveRecord::Migration[5.0]
  def change
    create_table :serialized_items do |t|
      t.references :store, foreign_key: true
      t.string :serial_number
      t.references :received_item, foreign_key: true
      t.references :sellable, foreign_key: true
      t.integer :quantity
      t.integer :lock_version

      t.timestamps
    end
  end
end
