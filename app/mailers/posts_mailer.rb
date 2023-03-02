class PostsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.posts_mailer.daily_mail.subject
  #
  before_action :set_user
  def daily_mail
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.posts_mailer.weekly_mail.subject
  #
  def weekly_mail
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
