class AddColumnToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :line_items, :plan, foreign_key: true
    add_reference :line_items, :payment, foreign_key: true
    add_column :line_items, :sale_type, :string
  end
end
