class EmailingService

  def relevant_timezones
    # get all timezones where it's pm
    relevant_timezones = ActiveSupport::TimeZone.all.select {|tz| tz.now.strftime('%H:%M') == '18:00' }.map(&:name)
  end

  def send_notification_emails_at_6pm!
    # for unread notifications
    users = User.where(timezone: relevant_timezones, email_notifications: true)
                .where.not(notifications_freq: nil)
                .where.not(notifications_freq: 'off')
    mail_type = 'notifications_freq'
    users.each do |user|
      mail_due = mail_due(user, mail_type)  
      if mail_due == 'daily_mail'
        notifications = user.notifications.unseen.where(created_at: 1.day.ago..Time.now).pluck(:id)                              
      else
        notifications = user.notifications.unseen.where(created_at: 1.week.ago..Time.now).pluck(:id)                        
      end
      NotificationsMailer.with(notifications_mailer_params(user, notifications)).send(mail_due(user, mail_type)).deliver_later
    end
  end

  def send_new_posts_emails_at_6pm!(timezones: relevant_timezones)
    # for new posts from people you follow
    users = User.where(timezone: ['UTC'], email_notifications: true)
                .where.not(new_article_notifications_freq: nil)
                .where.not(new_article_notifications_freq: 'off')
    
    mail_type = 'new_article_notifications_freq'
    users.each do |user|
      mail_due = mail_due(user, mail_type)  
      range_start = mail_due == 'daily_mail' ?  1.day.ago : 1.week.ago   
      posts = get_posts(user, 1.week.ago)
      next if posts.empty?
     
      PostsMailer.with(post_mailer_params(user,posts)).send(mail_due).deliver_later
    end
  end

  def send_new_performance_emails_at_6pm!
    # TODO: When analytics are set up, send a weekly email with performance updates
  end


  def send_product_updates!
    # TODO: when new updates are released
  end
  
  def get_posts(user, range_start)
    Post.published
        .where(published_at: range_start..Time.now)
        .where.not(user: user)
        .where(
          "(user_id IN (:user_followed_ids) AND publication_id IS NULL)
          OR (publication_id IN (:publication_followed_ids) AND publication_id IS NOT NULL)",
          user_followed_ids: user.followed_users.pluck(:id),
          publication_followed_ids: user.followed_publications.pluck(:id))
        .pluck(:id)
  end
  def post_mailer_params(user, posts)
    { 
      user_id: user.id,
      post_ids: posts
    }
  end

  def notifications_mailer_params(user, notifications)
    {
      user_id: user.id,
      notification_ids: notifications
    }
  
  end

  def mailer_params(user)
    { 
      user_id: user.id,
    }
  end

  def mail_due(user, mail_type)
    weekly_due = user.send(mail_type) == 'weekly' && Time.now.strftime('%A') == 'Saturday'
    
    weekly_due ? 'weekly_mail' : 'daily_mail' 
  end
end