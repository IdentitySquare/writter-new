module Notifiable
  extend ActiveSupport::Concern

  module ClassMethods
    def has_notifications
      has_many :notifications, as: :notifiable
     
    end
  end

  included do
    has_notifications
  end

  private


  
end
