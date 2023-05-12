class OnboardingController < ApplicationController
  skip_before_action :check_onboarding

  respond_to :json
  layout 'devise'
  def index
    @user = current_user
  end

  def checkUsername
    status = User.where("lower(username) = ?", params[:username].downcase).any? ? "error" : "success"  
    render json: {status: status}
  end
end