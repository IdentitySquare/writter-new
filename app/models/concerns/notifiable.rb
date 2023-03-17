module Notifiable
    extend ActiveSupport::Concern
  
    has_many :notifications, as: :notifiable

    after_create: :send_email if notifications_freq == 'instantly'
  
    private  

    def send_email
      NotificationsMailer.with(mailer_params(user)).instantly_mail.deliver_now
    end

    def mailer_params
      { 
        user_id: user.id,
      }
    end
end
  