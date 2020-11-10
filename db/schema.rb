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


ActiveRecord::Schema.define(version: 2020_11_10_115959) do


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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "customer_id", null: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.integer "bank_code"
    t.boolean "international", default: false
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
    t.boolean "international", default: false
    t.string "cnpj"
    t.string "email_notification"
    t.string "email_support"
    t.string "phone_support"
    t.string "shipment_origin_zipcode"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "cpf"
    t.string "birthday"
    t.string "pagarme_card"
    t.string "card_fingerprint"
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

  create_table "inventories", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_inventories_on_product_id"
  end

  create_table "kit_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "kit_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price_cents", default: 0, null: false
    t.index ["kit_id"], name: "index_kit_products_on_kit_id"
    t.index ["product_id"], name: "index_kit_products_on_product_id"
  end

  create_table "kits", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "payment_type"
    t.integer "standard_installments"
    t.integer "maximum_installments"
    t.string "shipment_description"
    t.boolean "allow_free_shipment", default: false
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.integer "length"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "plan_id"
    t.boolean "possale"
    t.integer "shipment_cost_cents", default: 0, null: false
    t.integer "discount"
    t.string "upsell"
    t.index ["plan_id"], name: "index_kits_on_plan_id"
  end

  create_table "orders", force: :cascade do |t|
    t.boolean "paid", default: false
    t.integer "installments"
    t.bigint "kit_id", null: false
    t.boolean "payment_method"
    t.decimal "price", precision: 8, scale: 2, null: false
    t.string "bank_slip_cpf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "address_id", null: false
    t.bigint "customer_id", null: false
    t.string "pagarme_transaction_id"
    t.string "boleto_url"
    t.string "boleto_bar_code"
    t.string "status"
    t.string "refused_reason"
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["kit_id"], name: "index_orders_on_kit_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "pagarme_id"
    t.integer "price"
    t.integer "days"
    t.integer "trial_days"
    t.string "payment_methods"
    t.integer "charges"
    t.integer "installments"
    t.integer "invoice_reminder"
    t.boolean "active", default: false
    t.boolean "visible", default: false
    t.boolean "deactivated", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.boolean "virtual", default: false
    t.string "name"
    t.string "sku"
    t.string "description"
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
    t.string "name"
    t.string "description"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.bigint "kit_id", null: false
    t.string "confirmation_page"
    t.index ["kit_id"], name: "index_selling_pages_on_kit_id"
    t.index ["slug"], name: "index_selling_pages_on_slug", unique: true
  end

  create_table "upsells", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_upsells_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "visits", force: :cascade do |t|
    t.bigint "order_id"
    t.string "fbid"
    t.string "utm_source"
    t.string "utm_campaign"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "pubid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_visits_on_order_id"
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "bank_accounts", "companies"
  add_foreign_key "campaigns", "selling_pages"
  add_foreign_key "inventories", "products"
  add_foreign_key "kit_products", "kits"
  add_foreign_key "kit_products", "products"
  add_foreign_key "kits", "plans"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "kits"
  add_foreign_key "products", "companies"
  add_foreign_key "selling_pages", "kits"
  add_foreign_key "upsells", "products"
  add_foreign_key "visits", "orders"
end
