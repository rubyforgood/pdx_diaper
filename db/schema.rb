# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160619151226) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "barcode_items", force: :cascade do |t|
    t.string   "value"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "quantity"
  end

  create_table "containers", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "item_id"
    t.integer  "itemizable_id"
    t.string   "itemizable_type"
  end

  add_index "containers", ["itemizable_id", "itemizable_type"], name: "index_containers_on_itemizable_id_and_itemizable_type"

  create_table "donations", force: :cascade do |t|
    t.string   "source"
    t.boolean  "completed",           default: false
    t.integer  "dropoff_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donations", ["dropoff_location_id"], name: "index_donations_on_dropoff_location_id"

  create_table "dropoff_locations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holdings", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "inventory_id"
    t.integer  "item_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "partners", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partner_id"
    t.integer  "inventory_id"
  end

  add_index "tickets", ["inventory_id"], name: "index_tickets_on_inventory_id"
  add_index "tickets", ["partner_id"], name: "index_tickets_on_partner_id"

end
