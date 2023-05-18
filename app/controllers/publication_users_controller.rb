class PublicationUsersController < ApplicationController
    before_action :set_publication
    
    def destroy
      authorize @publication_user
      # if this is the last admin for the publication, don't allow the user to be removed
      @publication_user.executor = current_user.id
      if @publication_user.destroy
        respond_to do |format|
          format.html { redirect_back(fallback_location: root_path)} 
        end
      end
    end

    private
  
    def set_publication
      @publication_user = PublicationUser.find(params[:id])
    end
    
  end