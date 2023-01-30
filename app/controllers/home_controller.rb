class HomeController < ApplicationController
  def index
    
    if !current_user
      redirect_to new_user_session_path 
    else

      redirect_to user_profile_path(current_user.id)
    end
  end
 end