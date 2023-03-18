class CommentsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :set_comment, only: %i[ destroy ]


  def create
    @comment = current_user.comments.new(comment_params)

    respond_to do |format|

      if @comment.save
        format.turbo_stream { flash.now[:notice] = "comment created" }

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    authorize @comment
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end
end
  