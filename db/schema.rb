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

ActiveRecord::Schema.define(version: 20170225210901) do

  create_table "accounts", force: :cascade do |t|
    t.integer "kid_id",  limit: 4
    t.string  "flavor",  limit: 255
    t.float   "balance", limit: 24
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "account_id",  limit: 4
    t.float    "amount",      limit: 24
    t.string   "action",      limit: 255
    t.datetime "happened_at"
  end

  create_table "assets", force: :cascade do |t|
    t.integer  "customer_id", limit: 4
    t.string   "flavor",      limit: 255
    t.float    "paid",        limit: 24
    t.float    "value",       limit: 24
    t.datetime "aquired_at"
  end

  create_table "atm_locations", force: :cascade do |t|
    t.decimal "lat",     precision: 20, scale: 15
    t.decimal "lon",     precision: 20, scale: 15
    t.decimal "heading", precision: 10
  end

  create_table "cards", force: :cascade do |t|
    t.integer  "kid_id",      limit: 4
    t.float    "amount",      limit: 24
    t.string   "action",      limit: 255
    t.string   "flavor",      limit: 255
    t.datetime "happened_at"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "fname",       limit: 255
    t.string   "lname",       limit: 255
    t.string   "email",       limit: 50
    t.string   "password",    limit: 255
    t.datetime "dob"
    t.integer  "admin_level", limit: 4,   default: 1
    t.integer  "level",       limit: 4,   default: 1
    t.datetime "rolled_at"
    t.float    "checking",    limit: 24
    t.float    "savings",     limit: 24
    t.float    "loan",        limit: 24
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true, using: :btree

  create_table "kid_grownups", force: :cascade do |t|
    t.integer "kid_id",     limit: 4
    t.integer "grownup_id", limit: 4
  end

  create_table "observers", force: :cascade do |t|
    t.integer "kid_id",      limit: 4
    t.integer "observer_id", limit: 4
    t.string  "flavor",      limit: 255
  end

  create_table "tokens", force: :cascade do |t|
    t.integer "customer_id", limit: 4
    t.string  "token",       limit: 50
    t.string  "flavor",      limit: 255
  end

  add_index "tokens", ["token"], name: "index_tokens_on_token", unique: true, using: :btree

end
