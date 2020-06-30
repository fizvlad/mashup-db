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

ActiveRecord::Schema.define(version: 2020_06_30_202848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "audios", force: :cascade do |t|
    t.string "title"
    t.integer "artist_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "audios_mashups", id: false, force: :cascade do |t|
    t.bigint "mashup_id", null: false
    t.bigint "audio_id", null: false
  end

  create_table "mashups", force: :cascade do |t|
    t.integer "audio_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["audio_id"], name: "index_mashups_on_audio_id", unique: true
  end

  create_table "mashups_posts", id: false, force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "mashup_id", null: false
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.integer "from_club"
    t.integer "from_user"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "likes", default: 0
    t.integer "reposts", default: 0
    t.integer "views", default: 0
    t.integer "comments", default: 0
    t.datetime "date", default: "1970-01-01 00:00:00"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", limit: 64
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "audios", "artists", on_update: :cascade, on_delete: :cascade
  add_foreign_key "mashups", "audios", on_update: :cascade, on_delete: :cascade
end
