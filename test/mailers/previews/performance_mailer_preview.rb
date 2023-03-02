# Preview all emails at http://localhost:3000/rails/mailers/performance_mailer
class PerformanceMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/performance_mailer/daily_mail
  def daily_mail
    PerformanceMailer.daily_mail
  end

  # Preview this email at http://localhost:3000/rails/mailers/performance_mailer/weekly_mail
  def weekly_mail
    PerformanceMailer.weekly_mail
  end

end
