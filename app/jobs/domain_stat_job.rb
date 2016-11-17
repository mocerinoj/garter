class DomainStatJob < ApplicationJob
  queue_as :default

  def perform(domain_id)
    domain = Domain.find(domain_id)

    plesk_api = PleskApiClient.new(host: domain.plesk_server.host)
    plesk_response = plesk_api.get_domain_stats(domain.plesk_id, domain.domain_type)
    return unless plesk_response.present? && plesk_response['packet'][domain.domain_type].present?

    result = plesk_response['packet'][domain.domain_type]['get']['result']['data']

    DomainStat.create!(domain: domain,
                       timestamp: Time.current,
                       total_size: result['gen_info']['real_size'],
                       stat: result['stat'],
                       disk_usage: result['disk_usage'])
  end
end
