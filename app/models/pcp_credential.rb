class PcpCredential < ApplicationRecord
  # ── Associations ──────────────────────────────────────────────
  belongs_to :pcp,       optional: true, class_name: "User", foreign_key: :pcp_id
  belongs_to :pcp_group, optional: true
  has_many :work_histories, dependent: :destroy
  accepts_nested_attributes_for :work_histories, allow_destroy: true, reject_if: :all_blank

  # ── Enums ─────────────────────────────────────────────────────
  enum :status, {
    pending:      0,
    submitted:    1,
    under_review: 2,
    approved:     3,
    denied:       4,
    expired:      5
  }, prefix: true

  enum :gender, {
    male:        0,
    female:      1,
    non_binary:  2,
    undisclosed: 3
  }, prefix: true

  enum :title_degree, {
    md:    0,
    do:    1,
    np:    2,
    pa:    3,
    phd:   4,
    dpm:   5,
    dds:   6,
    dmd:   7,
    od:    8,
    other: 9
  }, prefix: true

  enum :practitioner_role, {
    primary_care:     0,
    specialist:       1,
    hospitalist:      2,
    surgeon:          3,
    anesthesiologist: 4,
    radiologist:      5,
    psychiatrist:     6,
    other:            7
  }, prefix: true

  enum :speciality, {
    family_medicine:       0,
    internal_medicine:     1,
    pediatrics:            2,
    obstetrics_gynecology: 3,
    cardiology:            4,
    dermatology:           5,
    emergency_medicine:    6,
    endocrinology:         7,
    gastroenterology:      8,
    geriatrics:            9,
    hematology:            10,
    infectious_disease:    11,
    nephrology:            12,
    neurology:             13,
    oncology:              14,
    ophthalmology:         15,
    orthopedics:           16,
    otolaryngology:        17,
    pulmonology:           18,
    rheumatology:          19,
    urology:               20,
    other:                 21
  }, prefix: true

  # US states for DEA registration state
  enum :dea_state, {
    al: 0,  ak: 1,  az: 2,  ar: 3,  ca: 4,  co: 5,  ct: 6,  de: 7,
    fl: 8,  ga: 9,  hi: 10, id: 11, il: 12, in: 13, ia: 14, ks: 15,
    ky: 16, la: 17, me: 18, md: 19, ma: 20, mi: 21, mn: 22, ms: 23,
    mo: 24, mt: 25, ne: 26, nv: 27, nh: 28, nj: 29, nm: 30, ny: 31,
    nc: 32, nd: 33, oh: 34, ok: 35, or: 36, pa: 37, ri: 38, sc: 39,
    sd: 40, tn: 41, tx: 42, ut: 43, vt: 44, va: 45, wa: 46, wv: 47,
    wi: 48, wy: 49, dc: 50
  }, prefix: :dea

  # US states for medical license
  enum :medical_license_state, {
    al: 0,  ak: 1,  az: 2,  ar: 3,  ca: 4,  co: 5,  ct: 6,  de: 7,
    fl: 8,  ga: 9,  hi: 10, id: 11, il: 12, in: 13, ia: 14, ks: 15,
    ky: 16, la: 17, me: 18, md: 19, ma: 20, mi: 21, mn: 22, ms: 23,
    mo: 24, mt: 25, ne: 26, nv: 27, nh: 28, nj: 29, nm: 30, ny: 31,
    nc: 32, nd: 33, oh: 34, ok: 35, or: 36, pa: 37, ri: 38, sc: 39,
    sd: 40, tn: 41, tx: 42, ut: 43, vt: 44, va: 45, wa: 46, wv: 47,
    wi: 48, wy: 49, dc: 50
  }, prefix: :license

  # ── Validations ───────────────────────────────────────────────
  validates :first_name, :last_name, presence: true
  validates :npi, uniqueness: true, allow_blank: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :lowest_age_accepted, :highest_age_accepted,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :years_practicing,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  # ── Scopes ────────────────────────────────────────────────────
  scope :approved,              -> { where(approved: true) }
  scope :pending_review,        -> { status_pending.or(status_submitted).or(status_under_review) }
  scope :accepting_patients,    -> { where(accepting_new_patients: true) }
  scope :expiring_soon,         -> { where(expiration_date: Date.today..30.days.from_now) }
  scope :license_expiring_soon, -> { where(medical_license_expiration_date: Date.today..30.days.from_now) }

  # ── Instance Methods ──────────────────────────────────────────
  def full_name
    [title_degree&.upcase, first_name, middle_initial, last_name].compact_blank.join(" ")
  end

  def license_expired?
    medical_license_expiration_date.present? && medical_license_expiration_date < Date.today
  end

  def insurance_expired?
    insurance_expiration_date.present? && insurance_expiration_date < Date.today
  end

  def dea_expired?
    expiration_date.present? && expiration_date < Date.today
  end

  # ── Expiration status helpers ──────────────────────────────────
  EXPIRATION_CHECKS = {
    "DEA"                   => :expiration_date,
    "Medical License"       => :medical_license_expiration_date,
    "Board Certification"   => :board_certification_expiration_date,
    "Malpractice Insurance" => :insurance_expiration_date
  }.freeze

  # Returns array of hashes for any fields that are expired / expiring.
  # { label:, date:, status: (:expired | :expires_soon | :renew_soon), days_until: }
  def expiration_statuses
    today = Date.today
    EXPIRATION_CHECKS.map do |label, field|
      date = public_send(field)
      next if date.blank?

      days = (date - today).to_i

      status = if days < 0
        :expired
      elsif days <= 45
        :expires_soon
      elsif days <= 180
        :renew_soon
      end

      next unless status

      { label: label, date: date, status: status, days_until: days }
    end
  end
end
