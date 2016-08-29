class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :alias, null: false
      t.string :address
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone_number
      t.string :fax_number

      t.timestamps
    end
  end
end
