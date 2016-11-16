class WeeklyReportMailer < ApplicationMailer
  def admin_report
    @active_domains = Domain.active.hosted
    @domain_hosting_changed = @active_domains.select { |d| d.hosting_changed? }

    mail(to: 'joe@tntdental.com', subject: 'Garter - Weekly Admin Report')
  end
end
