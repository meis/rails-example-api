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

ActiveRecord::Schema.define(version: 2020_07_19_112741) do

  create_table "contents", force: :cascade do |t|
    t.integer "content_type", null: false
    t.string "title", null: false
    t.text "plot", null: false
    t.integer "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_type"], name: "index_contents_on_content_type"
    t.index ["title", "number"], name: "index_contents_on_title_and_number", unique: true
  end

  create_table "episodes", force: :cascade do |t|
    t.integer "content_id", null: false
    t.string "title", null: false
    t.integer "number", null: false
    t.text "plot", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id", "number"], name: "index_episodes_on_content_id_and_number", unique: true
    t.index ["content_id"], name: "index_episodes_on_content_id"
  end

  create_table "purchase_options", force: :cascade do |t|
    t.integer "content_id", null: false
    t.integer "quality"
    t.decimal "price", precision: 6, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id", "quality"], name: "index_purchase_options_on_content_id_and_quality", unique: true
    t.index ["content_id"], name: "index_purchase_options_on_content_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "purchase_options", "contents"
end
