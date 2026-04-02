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

ActiveRecord::Schema[7.1].define(version: 2026_03_19_164552) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pcp_credentials", force: :cascade do |t|
    t.string "practitioner_number"
    t.string "ssn"
    t.integer "dea_state"
    t.date "expiration_date"
    t.string "medical_license_number"
    t.integer "medical_license_state"
    t.date "medical_license_expiration_date"
    t.boolean "board_certified_status"
    t.string "hospital_certification_name"
    t.date "practitioner_birth_date"
    t.string "languages_spoken"
    t.string "medicare_identifier"
    t.string "email"
    t.string "insurance_carrier"
    t.float "insurance_coverage_amount"
    t.date "insurance_expiration_date"
    t.string "medical_school"
    t.string "residency"
    t.integer "years_practicing"
    t.bigint "pcp_id"
    t.bigint "pcp_group_id"
    t.string "npi"
    t.integer "gender"
    t.integer "speciality"
    t.string "middle_initial"
    t.string "first_name"
    t.string "last_name"
    t.boolean "accepting_new_patients"
    t.integer "lowest_age_accepted"
    t.integer "highest_age_accepted"
    t.integer "title_degree"
    t.integer "practitioner_role"
    t.integer "status"
    t.string "tax_id"
    t.string "document_1"
    t.string "document_2"
    t.string "document_3"
    t.boolean "receipt_confirmed"
    t.string "dea_number"
    t.boolean "approved"
    t.date "board_certification_expiration_date"
    t.date "board_certification_effective_date"
    t.string "board_certification_effective_type"
    t.string "board_certification_type"
    t.string "board_certification_type_secondary"
    t.date "board_certification_effective_date_secondary"
    t.string "primary_language"
    t.string "secondary_language"
    t.string "third_language"
    t.integer "taxonomy_code"
    t.string "secondary_speciality"
    t.string "medicaid_number"
    t.string "phone_number"
    t.string "insurance_policy_number"
    t.string "insurance_effective_date"
    t.date "approval_date"
    t.string "pcp_group_npi"
    t.string "pcp_group_tax_id"
    t.string "pcp_group_billing_address"
    t.string "pcp_group_billing_phone"
    t.string "board_certification_type_expiration_date_secondary"
    t.float "insurance_coverage_amount_aggregate"
    t.text "work_history_notes"
    t.string "cv"
    t.string "additional_document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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

end
