class SyncPleskDomainsJob < ApplicationJob
  queue_as :default

  def perform(server_id)
    plesk_server = PleskServer.find(server_id)
    plesk_response = PleskApiClient.new(host: plesk_server.host).get_domains
    return unless plesk_response.present?

    plesk_domains = plesk_response['packet']['webspace']['get']['result']
    plesk_domains.each do |plesk_domain|
      plesk_domain_id = plesk_domain['id']
      general_info = plesk_domain['data']['gen_info']
      hosting = plesk_domain['data']['hosting'][general_info['htype']]

      domain = Domain.where(plesk_server: plesk_server, plesk_id: plesk_domain_id).first_or_initialize
      domain.update!(name: general_info['name'],
                     status: general_info['status'],
                     ip_address: general_info['dns_ip_address'],
                     hosting_type: general_info['htype'],
                     last_updated_at: Time.current,
                     last_packet: plesk_domain['data'],
                     plesk_created_date: general_info['cr_date'],
                     domain_type: 'webspace')

      if general_info['htype'] == 'vrt_hst'
        is_ssl = false
        ftp_username = nil
        ftp_password = nil

        cert_name = hosting['property'].find { |p| p['name'] == 'certificate_name' }
        is_ssl = true if cert_name.present? && cert_name['value'].include?('Lets Encrypt')
        ftp_username = hosting['property'].find { |p| p['name'] == 'ftp_login' }['value']
        ftp_password = hosting['property'].find { |p| p['name'] == 'ftp_password' }['value']

        domain.update!(is_ssl: is_ssl,
                       ftp_username: ftp_username,
                       ftp_password: ftp_password)
      elsif hosting.present? && hosting['dest_url'].present?
        domain.update!(redirect_to: hosting['dest_url'])
      end
    end
  end
end
