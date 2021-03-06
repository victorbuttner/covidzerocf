# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_23_141938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "donations", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.decimal "value"
    t.string "payment_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "cpf"
    t.string "user_name"
    t.date "birthdate"
    t.string "phone"
    t.string "first_name"
    t.string "surname"
    t.string "address_street"
    t.integer "address_number"
    t.string "address_zipcode"
    t.string "address_reference"
    t.string "address_district"
    t.string "address_city"
    t.string "address_state"
    t.string "address_country"
    t.index ["project_id"], name: "index_donations_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.decimal "goal"
    t.decimal "quota_value"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "about"
    t.string "video_url"
    t.string "banner"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "cpf"
    t.string "phone"
    t.string "address_zipcode"
    t.string "address_city"
    t.string "address_neighborhood"
    t.string "address_state"
    t.string "address_street"
    t.integer "address_street_number"
    t.string "address_complement"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "donations", "projects"
end
