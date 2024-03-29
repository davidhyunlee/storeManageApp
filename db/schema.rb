# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161222105417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "card_receipts", force: :cascade do |t|
    t.integer  "number"
    t.integer  "drawer_count_id"
    t.decimal  "charged_amount",  precision: 10, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["drawer_count_id"], name: "index_card_receipts_on_drawer_count_id", using: :btree
  end

  create_table "carriers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "first_name",  null: false
    t.string   "middle_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "address"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.string   "last4"
    t.string   "pin"
    t.string   "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "store_id"
    t.index ["email"], name: "index_customers_on_email", using: :btree
    t.index ["store_id"], name: "index_customers_on_store_id", using: :btree
  end

  create_table "drawer_counts", force: :cascade do |t|
    t.integer  "ones"
    t.integer  "twos"
    t.integer  "fives"
    t.integer  "tens"
    t.integer  "twenties"
    t.integer  "fifties"
    t.integer  "hundreds"
    t.decimal  "total",      precision: 10, scale: 2
    t.decimal  "cash_total", precision: 10, scale: 2
    t.decimal  "card_total", precision: 10, scale: 2
    t.text     "note"
    t.integer  "user_id"
    t.integer  "store_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["store_id"], name: "index_drawer_counts_on_store_id", using: :btree
    t.index ["user_id"], name: "index_drawer_counts_on_user_id", using: :btree
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "user_id"
    t.integer  "store_id"
    t.decimal  "total",       precision: 10, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "sales_tax"
    t.decimal  "subtotal"
    t.string   "note"
    t.index ["customer_id"], name: "index_invoices_on_customer_id", using: :btree
    t.index ["store_id"], name: "index_invoices_on_store_id", using: :btree
    t.index ["user_id"], name: "index_invoices_on_user_id", using: :btree
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "invoice_id"
    t.integer  "sellable_id"
    t.integer  "serialized_item_id"
    t.integer  "quantity"
    t.decimal  "sold_price",         precision: 10, scale: 2
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "simple_item_id"
    t.decimal  "item_price"
    t.decimal  "tax_amount"
    t.integer  "plan_id"
    t.integer  "payment_id"
    t.integer  "sale_type_id"
    t.index ["invoice_id"], name: "index_line_items_on_invoice_id", using: :btree
    t.index ["payment_id"], name: "index_line_items_on_payment_id", using: :btree
    t.index ["plan_id"], name: "index_line_items_on_plan_id", using: :btree
    t.index ["sale_type_id"], name: "index_line_items_on_sale_type_id", using: :btree
    t.index ["sellable_id"], name: "index_line_items_on_sellable_id", using: :btree
    t.index ["serialized_item_id"], name: "index_line_items_on_serialized_item_id", using: :btree
    t.index ["simple_item_id"], name: "index_line_items_on_simple_item_id", using: :btree
  end

  create_table "numbers", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "carrier_id"
    t.string   "number",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "phone_model"
    t.string   "imei"
    t.string   "iccid"
    t.date     "act_date"
    t.index ["carrier_id"], name: "index_numbers_on_carrier_id", using: :btree
    t.index ["customer_id"], name: "index_numbers_on_customer_id", using: :btree
  end

  create_table "payment_types", force: :cascade do |t|
    t.string   "name"
    t.boolean  "fee"
    t.decimal  "fee_amount"
    t.integer  "carrier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_payment_types_on_carrier_id", using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.decimal  "amount",            precision: 10, scale: 2
    t.boolean  "verified",                                   default: false
    t.integer  "invoice_id"
    t.integer  "store_id"
    t.integer  "customer_id"
    t.integer  "carrier_id"
    t.integer  "user_id"
    t.integer  "number_id"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.integer  "payment_type_id"
    t.boolean  "invoiced",                                   default: false
    t.boolean  "employee_verified",                          default: false
    t.integer  "verifying_user"
    t.index ["carrier_id"], name: "index_payments_on_carrier_id", using: :btree
    t.index ["customer_id"], name: "index_payments_on_customer_id", using: :btree
    t.index ["invoice_id"], name: "index_payments_on_invoice_id", using: :btree
    t.index ["number_id"], name: "index_payments_on_number_id", using: :btree
    t.index ["payment_type_id"], name: "index_payments_on_payment_type_id", using: :btree
    t.index ["store_id"], name: "index_payments_on_store_id", using: :btree
    t.index ["user_id"], name: "index_payments_on_user_id", using: :btree
  end

  create_table "performance_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "performance_trackers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "invoice_id"
    t.integer  "performance_category_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["invoice_id"], name: "index_performance_trackers_on_invoice_id", using: :btree
    t.index ["performance_category_id"], name: "index_performance_trackers_on_performance_category_id", using: :btree
    t.index ["user_id"], name: "index_performance_trackers_on_user_id", using: :btree
  end

  create_table "plans", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.decimal  "price",       precision: 10, scale: 2
    t.integer  "carrier_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["carrier_id"], name: "index_plans_on_carrier_id", using: :btree
  end

  create_table "received_items", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "user_id"
    t.integer  "sellable_id"
    t.integer  "quantity"
    t.decimal  "cost"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["sellable_id"], name: "index_received_items_on_sellable_id", using: :btree
    t.index ["store_id"], name: "index_received_items_on_store_id", using: :btree
    t.index ["user_id"], name: "index_received_items_on_user_id", using: :btree
  end

  create_table "sale_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "tracked"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sellables", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "carrier_id"
    t.string   "name"
    t.string   "description"
    t.string   "sku"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "color"
    t.decimal  "msrp",              precision: 10, scale: 2
    t.decimal  "taxable_price",     precision: 10, scale: 2
    t.decimal  "retail_price",      precision: 10, scale: 2
    t.integer  "estimated_on_hand"
    t.boolean  "taxable"
    t.boolean  "serialized"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.decimal  "promo_price",       precision: 10, scale: 2
    t.decimal  "port_price",        precision: 10, scale: 2
    t.decimal  "upgrade_aal_price", precision: 10, scale: 2
    t.index ["carrier_id"], name: "index_sellables_on_carrier_id", using: :btree
    t.index ["category_id"], name: "index_sellables_on_category_id", using: :btree
  end

  create_table "serialized_items", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "serial_number"
    t.integer  "sellable_id"
    t.integer  "quantity"
    t.integer  "lock_version"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.boolean  "locked",                                 default: false
    t.integer  "user_id"
    t.decimal  "cost",          precision: 10, scale: 2
    t.index ["sellable_id"], name: "index_serialized_items_on_sellable_id", using: :btree
    t.index ["store_id"], name: "index_serialized_items_on_store_id", using: :btree
    t.index ["user_id"], name: "index_serialized_items_on_user_id", using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree
  end

  create_table "simple_items", force: :cascade do |t|
    t.integer  "store_id",    null: false
    t.integer  "sellable_id", null: false
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["sellable_id"], name: "index_simple_items_on_sellable_id", using: :btree
    t.index ["store_id"], name: "index_simple_items_on_store_id", using: :btree
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "alias",        null: false
    t.string   "address"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone_number"
    t.string   "fax_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "tenants", force: :cascade do |t|
    t.string   "goal"
    t.date     "date_applied"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "employment"
    t.string   "employment_contact"
    t.string   "paycheck_amount"
    t.string   "ssn"
    t.string   "phone_number"
    t.string   "email"
    t.string   "property_type"
    t.string   "bed"
    t.string   "bath"
    t.string   "laundry"
    t.string   "sqft"
    t.string   "rent_budget"
    t.string   "area"
    t.string   "move_in_date"
    t.text     "note"
    t.string   "family_count"
    t.string   "tenant_names"
    t.string   "pets"
    t.string   "current_lease"
    t.string   "current_address"
    t.string   "reference_name"
    t.string   "reference_contact"
    t.string   "introduced"
    t.string   "option_address1"
    t.string   "option_address2"
    t.string   "option_address3"
    t.string   "option_address4"
    t.string   "option_address5"
    t.string   "option_address6"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "card_receipts", "drawer_counts"
  add_foreign_key "customers", "stores"
  add_foreign_key "drawer_counts", "stores"
  add_foreign_key "drawer_counts", "users"
  add_foreign_key "invoices", "customers"
  add_foreign_key "invoices", "stores"
  add_foreign_key "invoices", "users"
  add_foreign_key "line_items", "invoices"
  add_foreign_key "line_items", "payments"
  add_foreign_key "line_items", "plans"
  add_foreign_key "line_items", "sale_types"
  add_foreign_key "line_items", "sellables"
  add_foreign_key "line_items", "serialized_items"
  add_foreign_key "line_items", "simple_items"
  add_foreign_key "numbers", "carriers"
  add_foreign_key "numbers", "customers"
  add_foreign_key "payment_types", "carriers"
  add_foreign_key "payments", "carriers"
  add_foreign_key "payments", "customers"
  add_foreign_key "payments", "invoices"
  add_foreign_key "payments", "numbers"
  add_foreign_key "payments", "payment_types"
  add_foreign_key "payments", "stores"
  add_foreign_key "payments", "users"
  add_foreign_key "performance_trackers", "invoices"
  add_foreign_key "performance_trackers", "performance_categories"
  add_foreign_key "performance_trackers", "users"
  add_foreign_key "plans", "carriers"
  add_foreign_key "received_items", "sellables"
  add_foreign_key "received_items", "stores"
  add_foreign_key "received_items", "users"
  add_foreign_key "sellables", "carriers"
  add_foreign_key "sellables", "categories"
  add_foreign_key "serialized_items", "sellables"
  add_foreign_key "serialized_items", "stores"
  add_foreign_key "serialized_items", "users"
  add_foreign_key "simple_items", "sellables"
  add_foreign_key "simple_items", "stores"
end
