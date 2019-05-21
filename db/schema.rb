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

ActiveRecord::Schema.define(version: 2019_05_21_193528) do

  create_table "containers", force: :cascade do |t|
    t.integer "dispenser_id"
    t.string "date"
    t.integer "start_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dispensers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_number"
    t.integer "capacity"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plants", force: :cascade do |t|
    t.integer "dispenser_id"
    t.string "name"
    t.string "location"
    t.integer "water_quantity"
    t.integer "water_frequency"
    t.string "last_day_watered"
    t.string "next_water_day"
    t.boolean "needs_water"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_token"
    t.string "google_refresh_token"
  end

  create_table "waterings", force: :cascade do |t|
    t.integer "plant_id"
    t.integer "container_id"
    t.integer "vacation_days"
    t.string "start_vacation"
    t.string "end_vacation"
    t.string "date"
    t.integer "leftover"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
