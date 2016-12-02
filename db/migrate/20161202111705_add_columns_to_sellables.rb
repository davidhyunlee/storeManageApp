class AddColumnsToSellables < ActiveRecord::Migration[5.0]
  def change
    add_column :sellables, :promo_price, :decimal, :precision => 10, :scale => 2
    add_column :sellables, :port_price, :decimal, :precision => 10, :scale => 2
  end
end
