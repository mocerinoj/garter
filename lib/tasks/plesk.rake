namespace :plesk do
  task sync_servers: :environment do
    SyncPleskServersJob.perform_now
  end

  task sync_domains: :environment do
    PleskServer.all.each do |plesk_server|
      SyncPleskDomainsJob.perform_now(plesk_server.id)
    end
  end

  task domain_stats: :environment do
    Domain.statable.each do |domain|
      DomainStatJob.perform_now(domain.id)
    end
  end
end
