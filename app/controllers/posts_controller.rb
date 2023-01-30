class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_post, only: %i[ show edit update destroy ]

  before_action :set_user, except: [:index]
  # GET /posts or /posts.json
  def index
    if params[:status].nil?
      @posts = Post.all
    else
      @posts = current_user.posts.where(status: params[:status])
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    if @user.posts.where(body: nil).any?
      redirect_to edit_post_path(@user.posts.where(body: nil).first)
    else
      @post = @user.posts.build
      if @post.save
         redirect_to edit_post_path(@post), notice: 'Post was successfully created.'
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update

    puts "params: #{params.inspect}"
    
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
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

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body, :title)
    end

    def set_user
      @user = current_user
    end
end
