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

ActiveRecord::Schema.define(version: 20160328220337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["order_id"], name: "index_comments_on_order_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "time"
    t.string   "status",             default: "upcoming"
    t.integer  "venue_id"
  end

  add_index "events", ["category_id"], name: "index_events_on_category_id", using: :btree
  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "listings", ["event_id"], name: "index_listings_on_event_id", using: :btree
  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "mailing_list_emails", force: :cascade do |t|
    t.string "email"
  end

  create_table "order_tickets", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_tickets", ["order_id"], name: "index_order_tickets_on_order_id", using: :btree
  add_index "order_tickets", ["ticket_id"], name: "index_order_tickets_on_ticket_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "street"
    t.string   "unit"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "status",      default: "paid"
    t.string   "fullname"
    t.string   "card_token"
    t.integer  "order_total"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.integer  "price"
    t.string   "seat"
    t.string   "row"
    t.integer  "listing_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "status",     default: "active"
  end

  add_index "tickets", ["listing_id"], name: "index_tickets_on_listing_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "role",            default: 0
    t.string   "fullname"
    t.string   "status",          default: "active"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "state"
  end

  add_foreign_key "comments", "orders"
  add_foreign_key "events", "categories"
  add_foreign_key "events", "venues"
  add_foreign_key "listings", "events"
  add_foreign_key "listings", "users"
  add_foreign_key "order_tickets", "orders"
  add_foreign_key "order_tickets", "tickets"
  add_foreign_key "orders", "users"
  add_foreign_key "tickets", "listings"
end
