namespace :email_updates do
  desc "send email updates to users at 6pm in their timezone"
  task send_emails: :environment do
    EmailingService.new.send_emails_at_6pm!
  end
end