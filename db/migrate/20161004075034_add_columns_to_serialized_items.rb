class AddColumnsToSerializedItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :serialized_items, :user, foreign_key: true
    add_column :serialized_items, :cost, :decimal, :precision => 10, :scale => 2
  end
end
