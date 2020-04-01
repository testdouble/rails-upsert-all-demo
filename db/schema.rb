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

ActiveRecord::Schema.define(version: 2020_04_01_023456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "charities", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.bigint "category_id"
    t.string "name", null: false
    t.string "ein", null: false
    t.string "mission_statement"
    t.string "zip_code", null: false
    t.boolean "accepting_donations"
    t.string "org_hunter_url", null: false
    t.string "donation_url", null: false
    t.string "web_site_url", null: false
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["category_id"], name: "index_charities_on_category_id"
    t.index ["city_id", "ein"], name: "index_charities_on_city_id_and_ein", unique: true
    t.index ["city_id"], name: "index_charities_on_city_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.string "state", null: false
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name", "state"], name: "index_cities_on_name_and_state", unique: true
  end

  add_foreign_key "charities", "categories"
  add_foreign_key "charities", "cities"
end
