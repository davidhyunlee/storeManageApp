class AddColumnsToNumber < ActiveRecord::Migration[5.0]
  def change
    add_column :numbers, :phone_model, :string
    add_column :numbers, :imei, :string
    add_column :numbers, :iccid, :string
    add_column :numbers, :act_date, :date
  end
end
