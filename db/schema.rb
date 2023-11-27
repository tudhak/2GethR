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

ActiveRecord::Schema[7.1].define(version: 2023_11_27_163100) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

  create_table "generic_tasks", force: :cascade do |t|
    t.string "title"
    t.integer "base_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["mood_category_id"], name: "index_statues_on_mood_category_id"
    t.index ["user_id"], name: "index_statues_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "date"
    t.integer "base_score"
    t.bigint "user_id", null: false
    t.string "statue"
    t.string "assigned_to"
    t.string "done_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["couple_id"], name: "index_users_on_couple_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "rewards", "users"
  add_foreign_key "statues", "mood_categories"
  add_foreign_key "statues", "users"
  add_foreign_key "tasks", "users"
  add_foreign_key "users", "couples"
end
