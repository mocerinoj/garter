# Preview all emails at http://localhost:3000/rails/mailers/weekly_report_mailer
class WeeklyReportMailerPreview < ActionMailer::Preview
  def admin_report
    WeeklyReportMailer.admin_report
  end
end
