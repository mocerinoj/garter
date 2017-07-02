class UpdateFtpPasswordJob < ApplicationJob
  queue_as :default

  def perform(domain_id)
    domain = Domain.find(domain_id)

    plesk_api = PleskApiClient.new(host: domain.plesk_server.host)
    new_password = SecureRandom.urlsafe_base64
    plesk_response = plesk_api.update_ftp_password(domain.plesk_id, domain.domain_type, new_password)
    return unless plesk_response.present? && plesk_response['packet']['site'].present? && plesk_response['packet']['site']['set'].present? && plesk_response['packet']['site']['set']['result'].present? && plesk_response['packet']['site']['set']['result']['status'].present? && plesk_response['packet']['site']['set']['result']['status'] == "ok"

    domain.events.create(activity: 'changed_ftp_password', data: { prev_password: domain.ftp_password, new_password: new_password })
  end
end
