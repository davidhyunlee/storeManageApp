class AddLockToSerializedItem < ActiveRecord::Migration[5.0]
  def change
    add_column :serialized_items, :locked, :boolean, default: false
  end
end
