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
    @follow = current_user.follows.new(follow_params)
    debugger
    @follow.save
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

  private
  def follow_params
   params.require(:follow).permit(:followable_id, :followable_type)
  end

end