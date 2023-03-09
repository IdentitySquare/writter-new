class PublicationsController < ApplicationController


  before_action :set_publication, only: [:show, :edit, :update]
  
  
  def new 
    @publication = Publication.new()
  end

  def show
  end

  def edit
  end

  def update
    if @publication.update(publication_params)
      redirect_to publication_path(@publication)
    end
  end

  def index
  end

  def manage
    @publications = current_user.publications
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
  

  private
  
  def publication_params
    params.require(:publication).permit(:name, :bio)
  end

  def set_publication
    @publication = Publication.find(params[:id])
  end
  
end