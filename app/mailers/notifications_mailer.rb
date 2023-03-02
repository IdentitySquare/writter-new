class NotificationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.daily_mail.subject
  #

  def instantly_mail
   
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def daily_mail
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.weekly_mail.subject
  #
  def weekly_mail
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
