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

ActiveRecord::Schema.define(version: 20180206164154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade, comment: "管理员" do |t|
    t.string "name", null: false, comment: "账号"
    t.string "password_digest", null: false, comment: "密码"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_admins_on_name", unique: true
  end

  create_table "identities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid", "provider"], name: "index_identities_on_uid_and_provider", unique: true
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "list_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "nick_name"
    t.integer "gender", default: 0
    t.string "language"
    t.string "city"
    t.string "province"
    t.string "country"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "identity_id"
    t.string "sid"
    t.string "session_key"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_sessions_on_identity_id"
    t.index ["sid"], name: "index_sessions_on_sid", unique: true
  end

  create_table "should_dos", force: :cascade do |t|
    t.bigint "list_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_should_dos_on_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "union_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["union_id"], name: "index_users_on_union_id", unique: true
  end

  add_foreign_key "identities", "users"
  add_foreign_key "lists", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "sessions", "identities"
  add_foreign_key "should_dos", "lists"
end
