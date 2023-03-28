 class PublicationsController < ApplicationController
  before_action :set_publication, only: [:show, :edit, :update, :destroy, :editor_view]
  
  def index
    @publications = current_user.publications
  end 

  def new 
    @publication = Publication.new()
  end

  def show
    @posts =  @publication.posts
  end

  def edit
  end

  def update
    if @publication.update(publication_params)
      redirect_to publication_path(@publication)
    end
  end

  
  def create
    @publication = Publication.new(publication_params)
    authorize @publication

    Publication.transaction do
      
      @publication.save!
      @publication_user = PublicationUser.new(publication: @publication, user: current_user, role: 'admin')
      @publication_user.save!
      redirect_to publication_path(@publication)
    end
  end

  def destroy
    authorize @publication
    @publication.destroy

    respond_to do |format|
      format.html { redirect_to publications_path} 
    end
  end

  def editor_view
    @published_posts = @publication.posts.published
    @draft_posts = @publication.posts.draft
    
  end

  private
  
  def publication_params
    params.require(:publication).permit(:name, :bio, :editor_emails, :invited_by, :admin_emails)
  end

  def set_publication
    @publication = Publication.find(params[:id])
  end
  
end