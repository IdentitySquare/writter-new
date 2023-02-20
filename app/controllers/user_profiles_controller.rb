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
  

  def follow
    debugger
    @follower = Follower.new(followee: @user, follower: current_user)
    if @follower.save
      redirect_to @user
    else
      flash[:error] = "Unable to follow user."
      redirect_to @user
    end
    current_user.followees << @user
    debugger
    redirect_back(fallback_location: root_path)
  end
  
  def unfollow
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: root_path)
  end
  private

  def set_user
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:name,:username,:bio, :website)
  end



end