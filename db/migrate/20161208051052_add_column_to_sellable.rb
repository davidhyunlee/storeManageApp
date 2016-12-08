class AddColumnToSellable < ActiveRecord::Migration[5.0]
  def change
    add_column :sellables, :upgrade_aal_price, :decimal, precision: 10, scale: 2
  end
end
