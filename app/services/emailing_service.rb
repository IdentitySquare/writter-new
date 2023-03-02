class EmailingService
  def send_emails_at_6pm!

    relevant_timezones = ActiveSupport::TimeZone.all.select {|tz| tz.now.strftime('%H') == '14' }.map(&:name)
    


    # for unread notifications
    users = User.where(timezone: relevant_timezones, notifications: true)
                .where.not(notifications_freq: nil)
                .where.not(notifications_freq: 'off')

    send_emails(NotificationsMailer, users, "notifications_freq")

    # for new articles
    users = User.where(timezone: relevant_timezones, notifications: true)
                .where.not(new_article_notifications_freq: nil)
                .where.not(new_article_notifications_freq: 'off')

    send_emails(PostsMailer, users, "new_article_notifications_freq")
  end

  def send_emails(mailer, users, attribute)
    users.each do |user|
      mailer_params = {
        user_id: user.id
      }
      mailer.with(mailer_params).send("#{user.send(attribute)}_mail").deliver_now 
    end
  end
   
end