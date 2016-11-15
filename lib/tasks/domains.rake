namespace :domains do
  task lookup: :environment do
    Domain.lookupable.each do |domain|
      DomainLookupJob.perform_now(domain.id)
    end
  end

  task pagespeed_test: :environment do
    Domain.pagespeedable.each do |domain|
      PagespeedTestJob.perform_now(domain.id)
    end
  end
end
