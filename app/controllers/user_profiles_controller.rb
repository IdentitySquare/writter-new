class UserProfilesController < ApplicationController
  before_action :set_user
  skip_before_action :check_onboarding

  def update 
    if @user.update(user_params)
      redirect_to root_path
    end
  end

  def show
    if params[:status].nil?
      @posts = Post.all
    else
      @posts = @user.posts.where(status: params[:status])
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name,:username,:bio, :website)
  end

end