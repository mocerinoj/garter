namespace :reports do
  task weekly_admin: :environment do
    if Time.current.monday?
      WeeklyReportMailer.admin_report.deliver_now
    end
  end
end
