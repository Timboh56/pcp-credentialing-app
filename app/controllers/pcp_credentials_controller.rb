class PcpCredentialsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_credential, only: %i[show edit update destroy]

  def index
    @credentials = PcpCredential.order(created_at: :desc)
  end

  def show; end

  def new
    @credential = PcpCredential.new
  end

  def create
    if params[:draft]
      @credential = PcpCredential.new
      @credential.save(validate: false)
      redirect_to edit_pcp_credential_path(@credential)
    else
      @credential = PcpCredential.new(credential_params)
      if @credential.save
        redirect_to @credential, notice: "Credential application submitted successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit; end

  def update
    if @credential.update(credential_params)
      respond_to do |format|
        format.html { redirect_to @credential, notice: "Credential updated successfully." }
        format.json { render json: { status: "saved" } }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { status: "error", errors: @credential.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @credential.destroy
    redirect_to pcp_credentials_path, notice: "Credential deleted."
  end

  private

  def set_credential
    @credential = PcpCredential.find(params[:id])
  end

  def credential_params
    params.require(:pcp_credential).permit(
      :first_name, :last_name, :middle_initial, :title_degree, :gender,
      :practitioner_birth_date, :email, :phone_number, :ssn, :tax_id,
      :npi, :practitioner_number, :practitioner_role, :speciality,
      :secondary_speciality, :taxonomy_code, :years_practicing,
      :accepting_new_patients, :lowest_age_accepted, :highest_age_accepted,
      :primary_language, :secondary_language, :third_language, :languages_spoken,
      :medical_school, :residency, :work_history_notes,
      :medical_license_number, :medical_license_state, :medical_license_expiration_date,
      :dea_number, :dea_state, :expiration_date,
      :medicare_identifier, :medicaid_number,
      :board_certified_status, :hospital_certification_name,
      :board_certification_type, :board_certification_type_secondary,
      :board_certification_effective_date, :board_certification_expiration_date,
      :board_certification_effective_type, :board_certification_effective_date_secondary,
      :board_certification_type_expiration_date_secondary,
      :insurance_carrier, :insurance_policy_number,
      :insurance_coverage_amount, :insurance_coverage_amount_aggregate,
      :insurance_expiration_date, :insurance_effective_date,
      :pcp_group_npi, :pcp_group_tax_id,
      :pcp_group_billing_address, :pcp_group_billing_phone,
      :document_1, :document_2, :document_3,
      :cv, :additional_document,
      :status, :approved, :approval_date, :receipt_confirmed,
      work_histories_attributes: [:id, :employer, :position, :work_start, :work_end, :_destroy]
    )
  end
end
