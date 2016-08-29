class CreateReceivedItems < ActiveRecord::Migration[5.0]
  def change
    create_table :received_items do |t|
      t.references :store, foreign_key: true
      t.references :user, foreign_key: true
      t.references :sellable, foreign_key: true
      t.integer :quantity
      t.decimal :cost

      t.timestamps
    end
  end
end
