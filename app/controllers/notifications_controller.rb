class NotificationsController < ApplicationController
    before_action :set_notification, only: %i[show ]

    def index
      @notifications = Notification.all
    end
    
    def show
      @notification.update(read_at: DateTime.now)
      redirect_to @notification.notifiable
    end
  
    private

    def set_notification
      @notification = Notification.find(params[:id])
    end
  end
    