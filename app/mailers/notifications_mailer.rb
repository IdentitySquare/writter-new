class NotificationsMailer < ApplicationMailer
  before_action :set_user
  before_action :set_notification, only: %i[instantly_mail ]
  before_action :set_notifications, only: %i[daily_mail weekly_mail ]

  def instantly_mail
    mail(
      to: "#{@user.name} <#{@user.email}>",
      subject: "You have a new notification!"
    )
  end

  def daily_mail
    mail(
      to: "#{@user.name} <#{@user.email}>",
      subject: "Notifications you've missed today"
    )
  end
  
  def weekly_mail
    mail(
      to: "#{@user.name} <#{@user.email}>",
      subject: "Notifications you've missed this week"
    )
  end
  
  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_notifications
    @notifications = Notification.find(params[:notifications_ids])
  end

  def set_notification
    @notification = Notification.find(params[:notification_id])
  end
end
