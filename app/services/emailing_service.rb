class EmailingService

  def relevant_timezones
    # get all timezones where it's pm
    relevant_timezones = ActiveSupport::TimeZone.all.select {|tz| tz.now.strftime('%H:%M') == '18:00' }.map(&:name)
  end

  def send_notification_emails_at_6pm!
    # for unread notifications
    users = User.where(timezone: relevant_timezones, notifications: true)
                .where.not(notifications_freq: nil)
                .where.not(notifications_freq: 'off')

    users.each do |user|
      NotificationsMailer.with(mailer_params(user)).send("#{user.notifications_freq}_mail").deliver_now
    end
    
  end

  def send_new_posts_emails_at_6pm!(timezones: relevant_timezones)
    # for new posts from people you follow
    
    users = User.where(timezone: timezones, notifications: true)
                .where.not(new_article_notifications_freq: nil)
                .where.not(new_article_notifications_freq: 'off')

    users.each do |user|
      posts = Post.published.where(published_at: 1.day.ago..Time.now)
              .where.not(user: user)
              .where(user: user.following)
      
      
      next if posts.empty?
      debugger
      PostsMailer.with(post_mailer_params(user,posts)).send("#{user.new_article_notifications_freq}_mail").deliver_later
    end
  end

  def send_new_performance_emails_at_6pm!
    # TODO: for new performance posts from people you follow, when analytics set up
  end
  
  def post_mailer_params(user, posts)
    { 
      user_id: user.id,
      posts: posts
    }
  end

  def mailer_params(user)
    { 
      user_id: user.id,
    }
  end
end