class NotificationsController < ApplicationController
    before_action :set_notification, only: [ :show ]
    
    def index
      @notifications = current_user.notifications.includes(:sender).order(created_at: :desc)
    end
    
    def show
      @notification.update(read_at: DateTime.now)

      if @notification.notifiable.is_a?(User)
        redirect_to user_profile_path(@notification.notifiable)
      else
        redirect_to @notification.notifiable
      end
    end

    def mark_as_read
      @notifications = current_user.notifications.includes(:sender).where(read_at: nil).order(created_at: :desc)
      @notifications.each do |notification|
        notification.update(read_at: DateTime.now)
      end

      redirect_back fallback_location: root_path
    end
  
    private

    def set_notification
      
      @notification = Notification.find(params[:id])
    end

   
  end
    