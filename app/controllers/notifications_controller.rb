class NotificationsController < ApplicationController
    before_action :set_notification, only: %i[show ]

    def index
      @notifications = current_user.notifications.includes(:sender)
    end
    
    def show
      @notification.update(read_at: DateTime.now)

      if @notification.notifiable.is_a?(User)
        redirect_to user_profile_path(@notification.notifiable)
      else
        redirect_to @notification.notifiable
      end
    end
  
    private

    def set_notification
      @notification = Notification.find(params[:id])
    end
  end
    