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

ActiveRecord::Schema[7.1].define(version: 2024_02_22_121731) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "couples", force: :cascade do |t|
    t.string "address"
    t.integer "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "generic_rewards", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "couple_id"
    t.string "emoji"
    t.index ["couple_id"], name: "index_generic_rewards_on_couple_id"
  end

  create_table "generic_tasks", force: :cascade do |t|
    t.string "title"
    t.integer "base_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.bigint "couple_id"
    t.string "emoji"
    t.index ["couple_id"], name: "index_generic_tasks_on_couple_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id", null: false
    t.bigint "couple_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["couple_id"], name: "index_messages_on_couple_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "mood_categories", force: :cascade do |t|
    t.string "title"
    t.string "image_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rewards", force: :cascade do |t|
    t.date "date"
    t.bigint "user_id", null: false
    t.string "status"
    t.text "description"
    t.string "title"
    t.integer "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "emoji"
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "statues", force: :cascade do |t|
    t.string "main_statue_message"
    t.string "love_statue_message"
    t.string "hate_statue_message"
    t.bigint "mood_category_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "end_date"
    t.datetime "start_date"
    t.boolean "autopilot", default: false
    t.index ["mood_category_id"], name: "index_statues_on_mood_category_id"
    t.index ["user_id"], name: "index_statues_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "date"
    t.integer "base_score"
    t.bigint "user_id", null: false
    t.string "status"
    t.string "assigned_to"
    t.string "done_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "emoji"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "nickname"
    t.date "date_of_birth"
    t.integer "score"
    t.string "mode"
    t.bigint "couple_id"
    t.string "received_actions"
    t.string "wishlist"
    t.index ["couple_id"], name: "index_users_on_couple_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "generic_rewards", "couples"
  add_foreign_key "generic_tasks", "couples"
  add_foreign_key "messages", "couples"
  add_foreign_key "messages", "users"
  add_foreign_key "rewards", "users"
  add_foreign_key "statues", "mood_categories"
  add_foreign_key "statues", "users"
  add_foreign_key "tasks", "users"
  add_foreign_key "users", "couples"
end
