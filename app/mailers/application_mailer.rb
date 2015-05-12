class ApplicationMailer < ActionMailer::Base
  default from: 'chapter9.28@gmail.com',
          bcc:  'chapter9.28@gmail.com'
  layout 'mailer'
end
