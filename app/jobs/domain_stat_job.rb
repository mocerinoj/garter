class DomainStatJob < ApplicationJob
  queue_as :default

  def perform(domain_id)
    domain = Domain.find(domain_id)

    plesk_response = PleskApiClient.new(host: domain.plesk_server.host).get_domain_stats(domain.plesk_id)
    return unless plesk_response.present? && plesk_response['packet']['webspace'].present?

    result = plesk_response['packet']['webspace']['get']['result']['data']

    DomainStat.create!(domain: domain,
                       timestamp: Time.current,
                       total_size: result['gen_info']['real_size'],
                       stat: result['stat'],
                       disk_usage: result['disk_usage'])
  end
end
