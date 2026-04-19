class TwoFactorController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_verified

  def show
    # DEV BYPASS: auto-verify in development
    if Rails.env.development?
      session[:two_factor_verified] = true
      return redirect_to authenticated_root_path, notice: "[Dev] 2FA bypassed."
    end
    # Only generate and send a new code if no valid one already exists
    send_otp unless current_user.otp_secret_expires_at&.future?
  end

  def verify
    if Rails.env.development? || current_user.valid_otp?(params[:otp_code])
      current_user.clear_otp!
      session[:two_factor_verified] = true
      redirect_to authenticated_root_path, notice: "Identity verified. Welcome back!"
    else
      flash.now[:alert] = "Invalid or expired code. Please try again."
      render :show, status: :unprocessable_entity
    end
  end

  def resend
    send_otp
    redirect_to two_factor_path, notice: "A new code has been sent to #{current_user.email}."
  end

  private

  def send_otp
    @code = current_user.generate_otp!
    OtpMailer.verification_email(current_user, @code).deliver_now
  end

  def redirect_if_verified
    redirect_to authenticated_root_path if session[:two_factor_verified]
  end
end
