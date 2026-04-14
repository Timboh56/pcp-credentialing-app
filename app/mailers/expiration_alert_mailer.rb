class ExpirationAlertMailer < ApplicationMailer
  def alert_email(credential, statuses)
    @credential = credential
    @statuses   = statuses
    mail(
      to:      credential.email,
      subject: "Action required: credential expiration alert for #{credential.full_name}"
    )
  end
end
