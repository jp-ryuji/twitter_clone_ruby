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

ActiveRecord::Schema.define(version: 20180228023042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "followings", force: :cascade do |t|
    t.integer "following_user_id", null: false
    t.integer "follower_id", null: false
    t.index ["follower_id", "following_user_id"], name: "index_followings_on_follower_id_and_following_user_id", unique: true
    t.index ["following_user_id"], name: "index_followings_on_following_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "id_token", null: false
    t.index ["id_token"], name: "index_posts_on_id_token", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string "name", limit: 20
    t.string "screen_name", limit: 15, null: false
    t.string "id_token", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id_token"], name: "index_users_on_id_token", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["screen_name"], name: "index_users_on_screen_name", unique: true
  end

  add_foreign_key "posts", "users"
end
