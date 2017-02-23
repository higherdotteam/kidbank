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

ActiveRecord::Schema.define(version: 20170223003236) do

  create_table "accounts", force: :cascade do |t|
    t.integer "kid_id"
    t.string  "flavor"
    t.float   "balance"
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "account_id"
    t.float    "amount"
    t.string   "action"
    t.datetime "happened_at"
  end

  create_table "assets", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "flavor"
    t.float    "paid"
    t.float    "value"
    t.datetime "aquired_at"
  end

  create_table "atm_locations", force: :cascade do |t|
    t.decimal "lat", precision: 20, scale: 15
    t.decimal "lon", precision: 20, scale: 15
  end

  create_table "cards", force: :cascade do |t|
    t.integer  "kid_id"
    t.float    "amount"
    t.string   "action"
    t.string   "flavor"
    t.datetime "happened_at"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email",       limit: 50
    t.string   "password"
    t.datetime "dob"
    t.integer  "admin_level",            default: 1
    t.integer  "level",                  default: 1
    t.datetime "rolled_at"
    t.float    "checking"
    t.float    "savings"
    t.float    "loan"
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true

  create_table "kid_grownups", force: :cascade do |t|
    t.integer "kid_id"
    t.integer "grownup_id"
  end

  create_table "observers", force: :cascade do |t|
    t.integer "kid_id"
    t.integer "observer_id"
    t.string  "flavor"
  end

  create_table "tokens", force: :cascade do |t|
    t.integer "customer_id"
    t.string  "token",       limit: 50
    t.string  "flavor"
  end

  add_index "tokens", ["token"], name: "index_tokens_on_token", unique: true

end
