class CreateTenants < ActiveRecord::Migration[5.0]
  def change
    create_table :tenants do |t|
      t.string :goal
      t.date :date_applied
      t.string :first_name
      t.string :last_name
      t.string :employment
      t.string :employment_contact
      t.string :paycheck_amount
      t.string :ssn
      t.string :phone_number
      t.string :email
      t.string :property_type
      t.string :bed
      t.string :bath
      t.string :laundry
      t.string :sqft
      t.string :rent_budget
      t.string :area
      t.string :move_in_date
      t.text :note
      t.string :family_count
      t.string :tenant_names
      t.string :pets
      t.string :current_lease
      t.string :current_address
      t.string :reference_name
      t.string :reference_contact
      t.string :introduced
      t.string :option_address1
      t.string :option_address2
      t.string :option_address3
      t.string :option_address4
      t.string :option_address5
      t.string :option_address6

      t.timestamps
    end
  end
end
