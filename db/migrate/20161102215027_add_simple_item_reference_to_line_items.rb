class AddSimpleItemReferenceToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :line_items, :simple_item, foreign_key: true
  end
end
