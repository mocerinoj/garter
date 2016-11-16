class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@tntsupport.net'
  layout 'mailer'
  helper DomainsHelper
end
