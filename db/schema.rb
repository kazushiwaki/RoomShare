# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_12_18_043808) do

  create_table "reservasions", force: :cascade do |t|
    t.date "check_in_date", null: false
    t.date "check_out_date", null: false
    t.integer "total_price"
    t.integer "guest_count", null: false
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_reservasions_on_room_id"
    t.index ["user_id"], name: "index_reservasions_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "address", null: false
    t.integer "price_per_night", null: false
    t.string "image"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.text "profile"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "reservasions", "rooms"
  add_foreign_key "reservasions", "users"
  add_foreign_key "rooms", "users"
end
