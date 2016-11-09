class AddColumnsToLineItem < ActiveRecord::Migration[5.0]
  def change
    add_column :line_items, :item_price, :decimal
    add_column :line_items, :tax_amount, :decimal
  end
end
