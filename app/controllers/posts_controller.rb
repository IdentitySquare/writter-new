class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_post, only: %i[ show edit update destroy publish unpublish ]
  
  before_action :set_user, except: [:index, :new]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    if current_user
      @non_authored_posts = RecommendationService.new(current_user).recommended_posts(10)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    if @post.draft?
      redirect_to edit_post_path(@post)
    end
  end

  # GET /posts/new
  def new
    
    if current_user.posts.where(draft_body: nil).any?
      redirect_to edit_post_path(current_user.posts.where(draft_body: nil).first)
    else
      @post = current_user.posts.build
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
    authorize @post
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    authorize @post

    respond_to do |format|
      
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    authorize @post
    respond_to do |format|
      if @post.update(post_params)
        
        format.turbo_stream { }
        format.html { redirect_back(fallback_location: root_path)}
        
        
        
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish 
    authorize @post
    @post.body = @post.draft_body
    @post.status = "published"
    @post.published_at = Time.now
    if @post.save
      redirect_to post_url(@post) 
    else
      render :edit
    end
  end

  def unpublish
    authorize @post
    @post.body = @post.draft_body
    @post.status = "draft"
    @post.published_at = nil
    @post.save
    redirect_to post_url(@post) 
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
      params.require(:post).permit(:body, :title, :draft_body,images:[])
    end

    def set_user
      @user = @post.user
    end
end
