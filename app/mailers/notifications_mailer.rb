class NotificationsMailer < ApplicationMailer
  before_action :set_user
  
  def instantly_mail
    mail(
      to: "#{@user.name} <#{@user.email}>",
      subject: "Notifications you've missed"
    )
  end

  def daily_mail
    mail(
      to: "#{@user.name} <#{@user.email}>",
      subject: "Notifications you've missed"
    )
  end
  
  def weekly_mail
    mail(
      to: "#{@user.name} <#{@user.email}>",
      subject: "Notifications you've missed"
    )
  end


  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
