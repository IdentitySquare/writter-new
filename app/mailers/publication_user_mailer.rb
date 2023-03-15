class PublicationUserMailer < ApplicationMailer
    before_action :set_user
    before_action :set_role
    before_action :set_publication
  
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

    def set_role
      @role = params[:role] 
    end

    def set_publication
      @publication = params[:publication]
    end
  end
  