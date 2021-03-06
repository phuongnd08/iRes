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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120621083429) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "enabled",    :default => true
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "price"
    t.boolean  "enabled",     :default => true
  end

  create_table "order_items", :force => true do |t|
    t.integer  "item_id"
    t.integer  "order_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "price"
    t.boolean  "ready",      :default => false
    t.string   "notes"
    t.boolean  "served"
    t.boolean  "paid"
  end

  create_table "orders", :force => true do |t|
    t.integer  "table_number"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "total_price",  :default => 0
    t.boolean  "ready",        :default => false
    t.boolean  "paid",         :default => false
    t.boolean  "served",       :default => false
    t.datetime "paid_at"
  end

  add_index "orders", ["created_at"], :name => "index_orders_on_created_at"

end
