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

ActiveRecord::Schema.define(version: 2022_06_19_093417) do

  create_table "datasets", id: { type: :binary, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.integer "images_count"
    t.integer "labels_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "image_sectors", id: { type: :binary, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.binary "image_id", null: false
    t.binary "label_id", null: false
    t.text "area_data", size: :long, null: false
    t.datetime "confirmed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "images", id: { type: :binary, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.binary "user_id", null: false
    t.binary "dataset_id", null: false
    t.string "file", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "labels", id: { type: :binary, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "category_name", null: false
    t.string "color_code", null: false
    t.string "category_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.binary "dataset_id", null: false
  end

  create_table "users", id: { type: :binary, limit: 36 }, charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role_type", default: 1
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
