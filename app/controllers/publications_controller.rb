class PublicationsController < ApplicationController
  before_action :set_user,  except: :manage

  def new 
    if @user.update(user_params)
      redirect_to root_path
    end
  end

  def manage
    @publications = current_user.publications
  end
  
  def create 
    if @user.update(user_params)
      redirect_to root_path
    end
  end
  

  # def show
  #   if params[:status].nil?
  #     @posts = @user.posts.published
  #   else
      
  #     @posts = @user.posts.where(status: params[:status])
  #   end
  # end
  

  # def follow
  #   @follow = current_user.given_follows.new(follow_params)
  #   @follow.save
  #   redirect_back(fallback_location: root_path)
  # end
  
  # def unfollow

  #   @follow = current_user.given_follows.find_by(followable: @user)
  #   @follow.destroy 
  #   redirect_back(fallback_location: root_path)
  # end

  # def followers
  #   @followers = @user.followers
  # end

  private
  def follow_params
    params.require(:follow).permit(:followable_id, :followable_type)
  end  
end