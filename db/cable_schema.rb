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

ActiveRecord::Schema[8.0].define(version: 2025_04_17_061620) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "current_addresses", force: :cascade do |t|
    t.string "unit"
    t.string "building"
    t.string "street"
    t.string "suburb"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "postal_code"
    t.string "landmark"
    t.bigint "verifiable_credential_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["verifiable_credential_id"], name: "index_current_addresses_on_verifiable_credential_id"
  end

  create_table "e_signatures", force: :cascade do |t|
    t.text "e_signature"
    t.bigint "verifiable_credential_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["verifiable_credential_id"], name: "index_e_signatures_on_verifiable_credential_id"
  end

  create_table "emails", force: :cascade do |t|
    t.string "email"
    t.bigint "verifiable_credential_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["verifiable_credential_id"], name: "index_emails_on_verifiable_credential_id"
  end

  create_table "foundational_ids", force: :cascade do |t|
    t.string "full_name"
    t.string "gender"
    t.date "date_of_birth"
    t.string "id_type"
    t.string "id_number"
    t.string "citizenship"
    t.string "household_number"
    t.string "blood_type"
    t.bigint "verifiable_credential_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["verifiable_credential_id"], name: "index_foundational_ids_on_verifiable_credential_id"
  end

  create_table "mobile_numbers", force: :cascade do |t|
    t.string "mobile_number"
    t.string "mobile_number_type"
    t.bigint "verifiable_credential_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["verifiable_credential_id"], name: "index_mobile_numbers_on_verifiable_credential_id"
  end

  create_table "passport_size_photos", force: :cascade do |t|
    t.text "passport_size_photo"
    t.bigint "verifiable_credential_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["verifiable_credential_id"], name: "index_passport_size_photos_on_verifiable_credential_id"
  end

  create_table "permanent_addresses", force: :cascade do |t|
    t.string "house_number"
    t.string "thram_number"
    t.string "village"
    t.string "gewog"
    t.string "dzongkhag"
    t.bigint "verifiable_credential_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["verifiable_credential_id"], name: "index_permanent_addresses_on_verifiable_credential_id"
  end

  create_table "solid_cable_messages", force: :cascade do |t|
    t.binary "channel", null: false
    t.binary "payload", null: false
    t.datetime "created_at", null: false
    t.bigint "channel_hash", null: false
    t.index ["channel"], name: "index_solid_cable_messages_on_channel"
    t.index ["channel_hash"], name: "index_solid_cable_messages_on_channel_hash"
    t.index ["created_at"], name: "index_solid_cable_messages_on_created_at"
  end

  create_table "verifiable_credentials", force: :cascade do |t|
    t.string "threaded_id"
    t.boolean "shared", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "current_addresses", "verifiable_credentials"
  add_foreign_key "e_signatures", "verifiable_credentials"
  add_foreign_key "emails", "verifiable_credentials"
  add_foreign_key "foundational_ids", "verifiable_credentials"
  add_foreign_key "mobile_numbers", "verifiable_credentials"
  add_foreign_key "passport_size_photos", "verifiable_credentials"
  add_foreign_key "permanent_addresses", "verifiable_credentials"
end
