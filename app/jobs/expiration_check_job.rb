class ExpirationCheckJob
  include Sidekiq::Job
  sidekiq_options queue: :default

  ALERT_STATUSES = %i[expired expires_soon renew_soon].freeze

  def perform
    Rails.logger.info "[ExpirationCheckJob] Running at #{Time.current}"

    PcpCredential.status_approved.find_each do |credential|
      statuses = credential.expiration_statuses
      next if statuses.empty?

      Rails.logger.info "[ExpirationCheckJob] Credential ##{credential.id} (#{credential.full_name}) has #{statuses.size} expiration alert(s)"

      recipient = credential.email.presence
      next unless recipient

      ExpirationAlertMailer.alert_email(credential, statuses).deliver_later
    end

    Rails.logger.info "[ExpirationCheckJob] Done."
  end
end
