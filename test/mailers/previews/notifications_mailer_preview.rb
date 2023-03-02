# Preview all emails at http://localhost:3000/rails/mailers/notifications_mailer
class NotificationsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifications_mailer/daily_mail
  def daily_mail
    NotificationsMailer.daily_mail
  end

  # Preview this email at http://localhost:3000/rails/mailers/notifications_mailer/weekly_mail
  def weekly_mail
    NotificationsMailer.weekly_mail
  end

end
