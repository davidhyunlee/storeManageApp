class AddSaleTypeReferenceToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :line_items, :sale_type, foreign_key: true
  end
end
