class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name
      t.date :dob
      t.string :address
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :email, index: true
      t.string :last4
      t.string :pin
      t.string :notes

      t.timestamps
    end
  end
end
