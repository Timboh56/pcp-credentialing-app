class CreatePcpCredentials < ActiveRecord::Migration[7.1]
  def change
    create_table :pcp_credentials do |t|
      t.string :practitioner_number
      t.string :ssn
      t.integer :dea_state
      t.date :expiration_date
      t.string :medical_license_number
      t.integer :medical_license_state
      t.date :medical_license_expiration_date
      t.boolean :board_certified_status
      t.string :hospital_certification_name
      t.date :practitioner_birth_date
      t.string :languages_spoken
      t.string :medicare_identifier
      t.string :email
      t.string :insurance_carrier
      t.float :insurance_coverage_amount
      t.date :insurance_expiration_date
      t.string :medical_school
      t.string :residency
      t.integer :years_practicing
      t.bigint :pcp_id
      t.bigint :pcp_group_id
      t.string :npi
      t.integer :gender
      t.integer :speciality
      t.string :middle_initial
      t.string :first_name
      t.string :last_name
      t.boolean :accepting_new_patients
      t.integer :lowest_age_accepted
      t.integer :highest_age_accepted
      t.integer :title_degree
      t.integer :practitioner_role
      t.integer :status
      t.string :tax_id
      t.string :document_1
      t.string :document_2
      t.string :document_3
      t.boolean :receipt_confirmed
      t.string :dea_number
      t.boolean :approved
      t.date :board_certification_expiration_date
      t.date :board_certification_effective_date
      t.string :board_certification_effective_type
      t.string :board_certification_type
      t.string :board_certification_type_secondary
      t.date :board_certification_effective_date_secondary
      t.string :primary_language
      t.string :secondary_language
      t.string :third_language
      t.integer :taxonomy_code
      t.string :secondary_speciality
      t.string :medicaid_number
      t.string :phone_number
      t.string :insurance_policy_number
      t.string :insurance_effective_date
      t.date :approval_date
      t.string :pcp_group_npi
      t.string :pcp_group_tax_id
      t.string :pcp_group_billing_address
      t.string :pcp_group_billing_phone
      t.string :board_certification_type_expiration_date_secondary
      t.float :insurance_coverage_amount_aggregate
      t.text :work_history_notes
      t.string :cv
      t.string :additional_document

      t.timestamps
    end
  end
end
