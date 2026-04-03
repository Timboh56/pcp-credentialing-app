class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ── Two-factor authentication via email OTP ─────────────────
  def generate_otp!
    code = SecureRandom.random_number(10**6).to_s.rjust(6, "0")
    update_columns(otp_secret: code, otp_secret_expires_at: 10.minutes.from_now)
    code
  end

  def valid_otp?(code)
    otp_secret.present? &&
      otp_secret_expires_at.present? &&
      otp_secret_expires_at > Time.current &&
      ActiveSupport::SecurityUtils.secure_compare(otp_secret.to_s, code.to_s.strip)
  end

  def clear_otp!
    update_columns(otp_secret: nil, otp_secret_expires_at: nil)
  end
end
