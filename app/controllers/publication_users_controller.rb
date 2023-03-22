class PublicationUsersController < ApplicationController
    before_action :set_publication
    
    def destroy
      @publication_user.destroy
      redirect_back(fallback_location: root_path)
    end

    private
  
    def set_publication
      @publication_user = PublicationUser.find(params[:id])
    end
    
  end