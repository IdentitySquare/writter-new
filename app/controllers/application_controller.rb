class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :check_onboarding, except: [:check_onboarding, :onboarding]
  before_action :set_paper_trail_whodunnit
 

  layout :layout_by_resource
  
  def check_onboarding
    if current_user && !current_user.onboarded?
      redirect_to onboarding_path
    end
  end


  def layout_by_resource
    if devise_controller? && action_name != "edit"
      "devise"
    else
      "application"
    end
  end
end
