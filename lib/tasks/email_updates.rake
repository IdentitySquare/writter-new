namespace :email_updates do
  desc "send email updates to users at 6pm in their timezone"
  task send_notification_emails: :environment do
    EmailingService.new.send_notification_emails_at_6pm!
  end

  task send_new_posts_emails: :environment do
    EmailingService.new.send_new_posts_emails_at_6pm!
  end

  task send_emails: :environment do
    EmailingService.new.send_performance_emails_at_6pm!
  end
end