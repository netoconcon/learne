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

ActiveRecord::Schema.define(version: 2020_07_03_151833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.integer "bank_code"
    t.boolean "international"
    t.string "bank_name"
    t.string "agency_number"
    t.string "account_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_bank_accounts_on_company_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.bigint "selling_page_id", null: false
    t.string "fbid"
    t.string "utm_source"
    t.string "utm_campaign"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "pubid"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["selling_page_id"], name: "index_campaigns_on_selling_page_id"
  end

  create_table "companies", force: :cascade do |t|
    t.boolean "international"
    t.string "CNPJ"
    t.string "email_notification"
    t.string "email_support"
    t.string "phone_support"
    t.string "shipment_origin_zipcode"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "kit_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "kit_id", null: false
    t.integer "quantity"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["kit_id"], name: "index_kit_products_on_kit_id"
    t.index ["product_id"], name: "index_kit_products_on_product_id"
  end

  create_table "kits", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "payment_type"
    t.integer "standard_installments"
    t.integer "maximum_installments"
    t.integer "shipment_cost"
    t.string "shipment_description"
    t.boolean "allow_free_shipment"
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.integer "length"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.boolean "virtual"
    t.string "name"
    t.string "sku"
    t.integer "price"
    t.string "description"
    t.integer "external_id"
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.integer "length"
    t.string "virtual_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "selling_pages", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "name"
    t.string "description"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_selling_pages_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bank_accounts", "companies"
  add_foreign_key "campaigns", "selling_pages"
  add_foreign_key "kit_products", "kits"
  add_foreign_key "kit_products", "products"
  add_foreign_key "products", "companies"
  add_foreign_key "selling_pages", "products"
end
