namespace :domains do
  task lookup: :environment do
    domains = Domain.lookupable

    domains.find_each do |domain|
      DomainLookupJob.perform_now(domain.id)
    end

    if domains.any? { |d| d.hosting_changed? }
      WeeklyReportMailer.admin_report.deliver_now
    end
  end

  task pagespeed_test: :environment do
    Domain.pagespeedable.each do |domain|
      PagespeedTestJob.perform_now(domain.id)
    end
  end
end
