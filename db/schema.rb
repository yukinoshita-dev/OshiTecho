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

ActiveRecord::Schema[8.1].define(version: 2026_04_25_200609) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "event_participations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "event_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["event_id"], name: "index_event_participations_on_event_id"
    t.index ["user_id", "event_id"], name: "index_event_participations_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_event_participations_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.time "end_time"
    t.date "event_date", null: false
    t.integer "event_type", default: 0, null: false
    t.boolean "expedition", default: false, null: false
    t.text "note"
    t.time "open_time"
    t.bigint "oshi_id", null: false
    t.integer "payment_status", default: 0, null: false
    t.string "seat"
    t.time "start_time"
    t.integer "ticket_price"
    t.string "title", null: false
    t.integer "transport", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "venue"
    t.integer "visibility", default: 0, null: false
    t.index ["oshi_id"], name: "index_events_on_oshi_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "followed_id"
    t.integer "follower_id"
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_follows_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_follows_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "oshi_anniversaries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.string "name", null: false
    t.bigint "oshi_id", null: false
    t.datetime "updated_at", null: false
    t.boolean "yearly", default: false, null: false
    t.index ["oshi_id"], name: "index_oshi_anniversaries_on_oshi_id"
  end

  create_table "oshis", force: :cascade do |t|
    t.string "color", default: "#ff69b4"
    t.datetime "created_at", null: false
    t.string "hashtag"
    t.string "instagram_url"
    t.string "name", null: false
    t.text "note"
    t.integer "position", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.string "tiktok_url"
    t.string "twitter_url"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "youtube_url"
    t.index ["user_id"], name: "index_oshis_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.string "token", null: false
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "display_name"
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.string "theme", default: "classic", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "event_participations", "events"
  add_foreign_key "event_participations", "users"
  add_foreign_key "events", "oshis"
  add_foreign_key "events", "users"
  add_foreign_key "follows", "users", column: "followed_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "oshi_anniversaries", "oshis"
  add_foreign_key "oshis", "users"
  add_foreign_key "sessions", "users"
end
