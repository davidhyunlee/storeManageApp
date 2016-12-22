class RemoveSaleTypeColumnFromLineItem < ActiveRecord::Migration[5.0]
  def change
    remove_column :line_items, :sale_type, :string
  end
end
