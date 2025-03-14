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

ActiveRecord::Schema[7.1].define(version: 2025_03_14_094015) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "name"
    t.string "street"
    t.string "zip"
    t.string "country"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "city"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "appellations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "box_exchanges", force: :cascade do |t|
    t.integer "exchange_id", null: false
    t.integer "box_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["box_id"], name: "index_box_exchanges_on_box_id"
    t.index ["exchange_id"], name: "index_box_exchanges_on_exchange_id"
  end

  create_table "boxes", force: :cascade do |t|
    t.integer "dividende_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "exchangeable", default: false
    t.string "delivery_method"
    t.string "delivery_address"
    t.index ["dividende_id"], name: "index_boxes_on_dividende_id"
    t.index ["user_id"], name: "index_boxes_on_user_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cuvee_colors", force: :cascade do |t|
    t.integer "cuvee_id", null: false
    t.integer "color_id", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["color_id"], name: "index_cuvee_colors_on_color_id"
    t.index ["cuvee_id"], name: "index_cuvee_colors_on_cuvee_id"
  end

  create_table "cuvees", force: :cascade do |t|
    t.integer "vinyard_appellation_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vinyard_appellation_id"], name: "index_cuvees_on_vinyard_appellation_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "delivery_method", default: "pickup", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "address_id"
    t.index ["address_id"], name: "index_deliveries_on_address_id"
    t.index ["user_id"], name: "index_deliveries_on_user_id"
  end

  create_table "dividende_cuvee_colors", force: :cascade do |t|
    t.integer "bottle_quantity"
    t.integer "dividende_id", null: false
    t.integer "cuvee_color_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuvee_color_id"], name: "index_dividende_cuvee_colors_on_cuvee_color_id"
    t.index ["dividende_id"], name: "index_dividende_cuvee_colors_on_dividende_id"
  end

  create_table "dividendes", force: :cascade do |t|
    t.integer "vinyard_id", null: false
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vinyard_id"], name: "index_dividendes_on_vinyard_id"
  end

  create_table "exchanges", force: :cascade do |t|
    t.string "status", default: "pending"
    t.integer "recipient_id"
    t.integer "initiator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_owners", force: :cascade do |t|
    t.integer "vinyard_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.index ["user_id"], name: "index_stock_owners_on_user_id"
    t.index ["vinyard_id"], name: "index_stock_owners_on_vinyard_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "pseudo", default: "", null: false
    t.string "delivery_address", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vinyard_appellations", force: :cascade do |t|
    t.integer "vinyard_id", null: false
    t.integer "appellation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appellation_id"], name: "index_vinyard_appellations_on_appellation_id"
    t.index ["vinyard_id"], name: "index_vinyard_appellations_on_vinyard_id"
  end

  create_table "vinyards", force: :cascade do |t|
    t.string "name"
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "box_exchanges", "boxes"
  add_foreign_key "box_exchanges", "exchanges"
  add_foreign_key "boxes", "dividendes"
  add_foreign_key "boxes", "users"
  add_foreign_key "cuvee_colors", "colors"
  add_foreign_key "cuvee_colors", "cuvees"
  add_foreign_key "cuvees", "vinyard_appellations"
  add_foreign_key "deliveries", "addresses", on_delete: :nullify
  add_foreign_key "deliveries", "users"
  add_foreign_key "dividende_cuvee_colors", "cuvee_colors"
  add_foreign_key "dividende_cuvee_colors", "dividendes"
  add_foreign_key "dividendes", "vinyards"
  add_foreign_key "stock_owners", "users"
  add_foreign_key "stock_owners", "vinyards"
  add_foreign_key "vinyard_appellations", "appellations"
  add_foreign_key "vinyard_appellations", "vinyards"
end
