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

ActiveRecord::Schema.define(version: 2021_04_13_092925) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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

  create_table "adjustments", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.decimal "amount"
    t.string "source_type", null: false
    t.bigint "source_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_adjustments_on_order_id"
    t.index ["source_type", "source_id"], name: "index_adjustments_on_source"
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
    t.integer "quantity", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "flag_quantities", default: 10
    t.text "observation"
    t.index ["product_id"], name: "index_inventories_on_product_id"
  end

  create_table "kit_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "kit_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "upsell", default: false, null: false
    t.decimal "price", precision: 8, scale: 2
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
    t.integer "discount"
    t.string "confirmation_page"
    t.string "slug", null: false
    t.string "upsell_message"
    t.decimal "shipment_cost", precision: 8, scale: 2
    t.decimal "price"
    t.index ["plan_id"], name: "index_kits_on_plan_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "upsell", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.boolean "paid", default: false
    t.integer "installments"
    t.bigint "kit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "address_id", null: false
    t.bigint "customer_id", null: false
    t.string "pagarme_transaction_id"
    t.string "boleto_url"
    t.string "boleto_bar_code"
    t.boolean "upsell_product"
    t.string "refused_reason"
    t.integer "status", default: 0
    t.string "cpf", null: false
    t.string "insts"
    t.datetime "expiration_date"
    t.integer "payment_method"
    t.decimal "price", precision: 8, scale: 2
    t.decimal "shipment_amount", null: false
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
    t.decimal "price", precision: 8, scale: 2
    t.decimal "cost", null: false
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "selling_pages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_selling_pages_on_product_id"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "campaign_id"
    t.index ["campaign_id"], name: "index_visits_on_campaign_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "customers"
  add_foreign_key "adjustments", "orders"
  add_foreign_key "bank_accounts", "companies"
  add_foreign_key "campaigns", "selling_pages"
  add_foreign_key "inventories", "products"
  add_foreign_key "kit_products", "kits"
  add_foreign_key "kit_products", "products"
  add_foreign_key "kits", "plans"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "kits"
  add_foreign_key "products", "companies"
  add_foreign_key "selling_pages", "products"
  add_foreign_key "upsells", "products"
end
