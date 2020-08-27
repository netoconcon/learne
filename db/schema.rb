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

ActiveRecord::Schema.define(version: 2020_08_27_151618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.integer "number"
    t.string "neighborhood"
    t.string "complement"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.integer "bank_code", null: false
    t.boolean "international", default: false, null: false
    t.string "bank_name", null: false
    t.string "agency_number", null: false
    t.string "account_number", null: false
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
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["selling_page_id"], name: "index_campaigns_on_selling_page_id"
  end

  create_table "companies", force: :cascade do |t|
    t.boolean "international", default: false, null: false
    t.string "cnpj", null: false
    t.string "email_notification", null: false
    t.string "email_support", null: false
    t.string "phone_support", null: false
    t.string "shipment_origin_zipcode", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "kit_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "kit_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price_cents", default: 0, null: false
    t.index ["kit_id"], name: "index_kit_products_on_kit_id"
    t.index ["product_id"], name: "index_kit_products_on_product_id"
  end

  create_table "kits", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "payment_type", null: false
    t.integer "standard_installments"
    t.integer "maximum_installments", null: false
    t.integer "shipment_cost", null: false
    t.string "shipment_description"
    t.boolean "allow_free_shipment", default: false, null: false
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.integer "length"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.boolean "paid", default: false, null: false
    t.integer "installments", null: false
    t.bigint "kit_id", null: false
    t.boolean "payment_method", default: false, null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "address_id", null: false
    t.bigint "user_id", null: false
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["kit_id"], name: "index_orders_on_kit_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.boolean "virtual", default: false, null: false
    t.string "name", null: false
    t.string "sku", null: false
    t.string "description", null: false
    t.integer "external_id"
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.integer "length"
    t.string "virtual_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price_cents", default: 0, null: false
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "selling_pages", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.bigint "kit_id", null: false
    t.index ["kit_id"], name: "index_selling_pages_on_kit_id"
    t.index ["slug"], name: "index_selling_pages_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone"
    t.string "cpf"
    t.string "birthday"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "bank_accounts", "companies"
  add_foreign_key "campaigns", "selling_pages"
  add_foreign_key "kit_products", "kits"
  add_foreign_key "kit_products", "products"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "kits"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "companies"
  add_foreign_key "selling_pages", "kits"
end
