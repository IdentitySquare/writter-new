class NotificationsController < ApplicationController
    before_action :set_follow, only: %i[show ]

    def index
        @notifications = Notification.all
    end
    
    def show
    # mark as read redirect to object
    end
  
    private

    def set_notification
      @notification = Notification.find(params[:id])
    end
  end
    