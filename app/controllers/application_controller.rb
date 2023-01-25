class ApplicationController < ActionController::Base
  before_action :check_onboarding, except: [:check_onboarding, :onboarding]
  protect_from_forgery unless: -> { request.format.json? }

  def check_onboarding
    if current_user && !current_user.onboarded?
      redirect_to onboarding_path
    end
  end
end
