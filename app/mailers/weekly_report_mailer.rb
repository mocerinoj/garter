class WeeklyReportMailer < ApplicationMailer
  def admin_report
    @active_domains = Domain.active.hosted.includes(:domain_lookups)
    @domain_hosting_changed = @active_domains.select { |d| d.hosting_changed? }

    mail(to: ENV["ADMIN_EMAILS"], subject: 'Garter - Weekly Admin Report')
  end
end
