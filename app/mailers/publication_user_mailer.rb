class PublicationUserMailer < ApplicationMailer
    before_action :set_user
  
    def invited_to_join  
      mail(
        to: "#{@user.name} <#{@user.email}>",
        subject: 'Join to be a part of this publication'
      )
    end
  
    def added_to_publication
      mail(
          to: "#{@user.name} <#{@user.email}>",
          subject: 'Youve been added to a publication'
        )
    end

    private
    def set_user
      @user = params[:user]
    end
  end
  