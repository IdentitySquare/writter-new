class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy ]

  def create

    if current_user
      @comment = current_user.comments.new(comment_params)

      respond_to do |format|
        if @comment.save
          format.turbo_stream
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end

    else
      redirect_to new_user_session_path 
    end

  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    authorize @comment
    @comment.discard

    respond_to do |format|
      format.turbo_stream {}
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end
    
    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end
end
  