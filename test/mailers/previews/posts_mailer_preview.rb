# Preview all emails at http://localhost:3000/rails/mailers/posts_mailer
class PostsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/posts_mailer/daily_mail
  def daily_mail
    PostsMailer.daily_mail
  end

  # Preview this email at http://localhost:3000/rails/mailers/posts_mailer/weekly_mail
  def weekly_mail
    PostsMailer.weekly_mail
  end

end
