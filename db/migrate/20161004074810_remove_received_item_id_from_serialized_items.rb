class RemoveReceivedItemIdFromSerializedItems < ActiveRecord::Migration[5.0]
  def change
    remove_reference :serialized_items, :received_item, foreign_key: true
  end
end
