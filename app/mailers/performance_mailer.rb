class PerformanceMailer < ApplicationMailer
  before_action :set_user
  before_action :calculate_performance
  
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

  def calculate_performance
    range = @user.performance_notifications_freq == 'daily' ? 1.day.ago : 1.week.ago
    @performance_hash = @user.get_views(range)
  end



end
