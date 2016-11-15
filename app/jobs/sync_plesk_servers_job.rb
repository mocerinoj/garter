class SyncPleskServersJob < ApplicationJob
  queue_as :default

  def perform
    plesk_servers = PleskServer.all

    plesk_servers.each do |plesk_server|
      plesk_response = PleskApiClient.new(host: plesk_server.host).get_server
      next unless plesk_response.present?

      result = plesk_response['packet']['server']['get']['result']
      general_info = result['gen_info']
      plesk_server.update!(name: general_info['server_name'])

      server_stats = result['stat']
      PleskServerStat.create!(plesk_server: plesk_server,
                              timestamp: Time.current,
                              domains: server_stats['objects']['domains'],
                              active_domains: server_stats['objects']['active_domains'],
                              plesk_version: server_stats['version']['plesk_version'],
                              load_avg: server_stats['load_avg'],
                              mem: server_stats['mem'],
                              diskspace: server_stats['diskspace'])
    end
  end
end
