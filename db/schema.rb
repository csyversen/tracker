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

ActiveRecord::Schema.define(version: 20140210214541) do

  create_table "prices", force: true do |t|
    t.integer  "product_id"
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "sale_site"
    t.string   "asin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumb_url"
  end

  create_table "products_users", id: false, force: true do |t|
    t.integer "product_id"
    t.integer "user_id"
  end

  add_index "products_users", ["product_id", "user_id"], name: "index_products_users_on_product_id_and_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "salt",            limit: 64
    t.string   "password_digest", limit: 64
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
