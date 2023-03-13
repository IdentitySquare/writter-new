class PerformanceMailer < ApplicationMailer
  before_action :set_user
  
  def daily_mail
    mail(
      to: "#{@user.name} <#{@user.email}>",
      subject: "Today's Performance Report"
    )
  end

 
  def weekly_mail
    mail(
      to: "#{@user.name} <#{@user.email}>",
      subject: "This week's performance report"
    )
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
