namespace :audits do
  task change_bad_passwords: :environment do
    Domain.where(ftp_password: 'tnt2676').each do |domain|
      UpdateFtpPasswordJob.perform_now(domain.id)
    end
  end
end
