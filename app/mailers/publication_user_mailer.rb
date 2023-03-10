class PublicationUserMailer < ApplicationMailer
    before_action :set_user
  
    def invited_to_join  
      mail(
        to: "#{@user.name} <#{@user.email}>",
        subject: 'Continuing with Ready Set Recover'
      )
    end
  
    def added_to_publication
      mail(
          to: "#{@user.name} <#{@user.email}>",
          subject: 'Continuing with Ready Set Recover'
        )
    end

    private
  
  end
  