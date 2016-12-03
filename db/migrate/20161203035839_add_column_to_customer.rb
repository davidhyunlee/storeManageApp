class AddColumnToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_reference :customers, :store, foreign_key: true
  end
end
