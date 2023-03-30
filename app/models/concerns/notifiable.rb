module Notifiable
  extend ActiveSupport::Concern

  module ClassMethods
    def has_notifications
      has_many :notifications, as: :notifiable
      # after_create :send_email, if: -> { user.notifications_freq == 'instantly' }
      # after_create :create_notification

    end
  end

  included do
    has_notifications
  end

  private

  def create_notification

    Notification.create(notifiable: self, user: self.post.user)
  end

  def send_email
    NotificationsMailer.with(mailer_params(user)).instantly_mail.deliver_now
  end

  def mailer_params
    { 
      user_id: user.id,
    }
  end
end
