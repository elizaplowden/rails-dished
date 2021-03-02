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


ActiveRecord::Schema.define(version: 2021_03_02_121203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "cookbook_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cookbook_id"], name: "index_bookmarks_on_cookbook_id"
    t.index ["recipe_id"], name: "index_bookmarks_on_recipe_id"
  end

  create_table "cookbooks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_cookbooks_on_user_id"
  end

  create_table "followings", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "followee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followee_id"], name: "index_followings_on_followee_id"
    t.index ["follower_id"], name: "index_followings_on_follower_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "quantity"
    t.bigint "food_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_id"], name: "index_ingredients_on_food_id"
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "description"
    t.bigint "bookmark_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bookmark_id"], name: "index_notes_on_bookmark_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "instructions"
    t.string "meal"
    t.string "cuisine"
    t.integer "serves"
    t.integer "cook_time"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "description"
    t.integer "rating"
    t.bigint "recipe_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_reviews_on_recipe_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookmarks", "cookbooks"
  add_foreign_key "bookmarks", "recipes"
  add_foreign_key "cookbooks", "users"
  add_foreign_key "followings", "users", column: "followee_id"
  add_foreign_key "followings", "users", column: "follower_id"
  add_foreign_key "ingredients", "foods"
  add_foreign_key "ingredients", "recipes"
  add_foreign_key "notes", "bookmarks"
  add_foreign_key "recipes", "users"
  add_foreign_key "reviews", "recipes"
  add_foreign_key "reviews", "users"
end
