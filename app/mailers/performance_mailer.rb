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


  def calculate_performance(@user)
    range = @user.notifications_frequency == 'daily' ? 1.day.ago : 1.week.ago

    get_views(@user, range)

  end

  def get_views(@user, start_time)
    post_ids = @user.posts.published.pluck(:id)
    end_time = Time.now

    result = ActiveRecord::Base.connection.execute("
              SELECT properties->>'post_id' AS post_id, COUNT(*) AS visit_count
              FROM ahoy_events
              WHERE name = 'post viewed'
                AND properties->>'post_id' IN ('1', '2', '3')
                AND time BETWEEN '#{start_time}' AND '#{end_time}'
              GROUP BY properties->>'post_id'
            ")

    @post_views = {}

    result.values.each do |row|
      @post_views[row[0]] = row[1]
    end
    
    @post_views
  end

end
