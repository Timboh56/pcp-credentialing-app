class OtpMailer < ApplicationMailer
  def verification_email(user, code)
    @user = user
    @code = code
    mail(to: @user.email, subject: "Your PCP Credentialing verification code")
  end
end
