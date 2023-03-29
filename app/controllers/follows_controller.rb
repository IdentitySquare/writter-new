class FollowsController < ApplicationController
    before_action :set_follow, only: %i[destroy ]

    def create
      @follow = current_user.given_follows.new(follow_params)
      
      respond_to do |format|
        if @follow.save
          redirect_back(fallback_location: root_path)
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def destroy
      @follow.destroy 
      redirect_back(fallback_location: root_path)
    end
  
    private

    def set_follow
      @follow = Follow.find(params[:id])
    end

    def follow_params
      params.require(:follow).permit(:followable_id, :followable_type)
    end
  end
    