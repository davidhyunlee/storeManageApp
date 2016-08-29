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

ActiveRecord::Schema.define(version: 20160829225524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["email"], name: "index_customers_on_email", using: :btree
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "user_id"
    t.integer  "store_id"
    t.decimal  "total"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["customer_id"], name: "index_invoices_on_customer_id", using: :btree
    t.index ["store_id"], name: "index_invoices_on_store_id", using: :btree
    t.index ["user_id"], name: "index_invoices_on_user_id", using: :btree
  end

  create_table "numbers", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "carrier_id"
    t.string   "number",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["carrier_id"], name: "index_numbers_on_carrier_id", using: :btree
    t.index ["customer_id"], name: "index_numbers_on_customer_id", using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.decimal  "amount",       precision: 10, scale: 2
    t.string   "payment_type"
    t.integer  "invoice_id"
    t.integer  "store_id"
    t.integer  "customer_id"
    t.integer  "carrier_id"
    t.integer  "user_id"
    t.integer  "number_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["carrier_id"], name: "index_payments_on_carrier_id", using: :btree
    t.index ["customer_id"], name: "index_payments_on_customer_id", using: :btree
    t.index ["invoice_id"], name: "index_payments_on_invoice_id", using: :btree
    t.index ["number_id"], name: "index_payments_on_number_id", using: :btree
    t.index ["store_id"], name: "index_payments_on_store_id", using: :btree
    t.index ["user_id"], name: "index_payments_on_user_id", using: :btree
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

  create_table "sellables", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "carrier_id"
    t.string   "description"
    t.string   "sku"
    t.decimal  "msrp"
    t.decimal  "taxable_price"
    t.decimal  "retail_price"
    t.integer  "estimated_on_hand"
    t.boolean  "taxable"
    t.boolean  "serialized"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["carrier_id"], name: "index_sellables_on_carrier_id", using: :btree
    t.index ["category_id"], name: "index_sellables_on_category_id", using: :btree
  end

  create_table "serialized_items", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "serial_number"
    t.integer  "received_item_id"
    t.integer  "sellable_id"
    t.integer  "quantity"
    t.integer  "lock_version"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["received_item_id"], name: "index_serialized_items_on_received_item_id", using: :btree
    t.index ["sellable_id"], name: "index_serialized_items_on_sellable_id", using: :btree
    t.index ["store_id"], name: "index_serialized_items_on_store_id", using: :btree
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

  add_foreign_key "invoices", "customers"
  add_foreign_key "invoices", "stores"
  add_foreign_key "invoices", "users"
  add_foreign_key "numbers", "carriers"
  add_foreign_key "numbers", "customers"
  add_foreign_key "payments", "carriers"
  add_foreign_key "payments", "customers"
  add_foreign_key "payments", "invoices"
  add_foreign_key "payments", "numbers"
  add_foreign_key "payments", "stores"
  add_foreign_key "payments", "users"
  add_foreign_key "received_items", "sellables"
  add_foreign_key "received_items", "stores"
  add_foreign_key "received_items", "users"
  add_foreign_key "sellables", "carriers"
  add_foreign_key "sellables", "categories"
  add_foreign_key "serialized_items", "received_items"
  add_foreign_key "serialized_items", "sellables"
  add_foreign_key "serialized_items", "stores"
end