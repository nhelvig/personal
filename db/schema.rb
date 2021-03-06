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

ActiveRecord::Schema.define(version: 20160904194439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holdings", force: :cascade do |t|
    t.date    "date",          null: false
    t.string  "symbol",        null: false
    t.decimal "quantity",      null: false
    t.decimal "closing_price", null: false
  end

  add_index "holdings", ["date"], name: "index_holdings_on_date", using: :btree

  create_table "investments", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "symbol"
    t.decimal  "avg_cost"
    t.decimal  "current_price"
    t.decimal  "total_value"
    t.decimal  "quantity"
  end

  create_table "totals", force: :cascade do |t|
    t.date    "date",              null: false
    t.decimal "total_value",       null: false
    t.decimal "total_invested"
    t.decimal "available_cash"
    t.decimal "total_dividend"
    t.decimal "percentage_change"
  end

  add_index "totals", ["date"], name: "index_totals_on_date", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "stock_id"
    t.decimal  "price"
    t.string   "action"
    t.decimal  "quantity"
    t.decimal  "commission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "symbol"
    t.date     "date"
  end

  add_index "transactions", ["date"], name: "index_transactions_on_date", using: :btree

end
