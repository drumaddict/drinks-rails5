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

ActiveRecord::Schema.define(version: 20160716213940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drink_categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "has_sugar",  default: false
    t.boolean  "has_milk",   default: false
    t.integer  "role",       default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "drinks", force: :cascade do |t|
    t.integer  "drink_category_id"
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["drink_category_id"], name: "index_drinks_on_drink_category_id", using: :btree
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "drink_id"
    t.integer  "drink_category_id"
    t.integer  "sugar",             default: 0
    t.integer  "milk",              default: 0
    t.integer  "quantity",          default: 1
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["drink_category_id"], name: "index_line_items_on_drink_category_id", using: :btree
    t.index ["drink_id"], name: "index_line_items_on_drink_id", using: :btree
    t.index ["order_id"], name: "index_line_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.boolean  "favorite",   default: false
    t.boolean  "reoccuring", default: false
    t.text     "comments"
    t.text     "days",       default: [],                 array: true
    t.integer  "hour"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "role",            default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["company_id"], name: "index_users_on_company_id", using: :btree
  end

  add_foreign_key "drinks", "drink_categories"
  add_foreign_key "line_items", "drink_categories"
  add_foreign_key "line_items", "drinks"
  add_foreign_key "line_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "users", "companies"
end
