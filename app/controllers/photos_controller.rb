class PhotosController < ApplicationController

  # GET /
  def index
    @photos = Photo.where("approved_at IS NOT NULL").order("created_at DESC")
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end
  
  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html { }#render layout: false } # show.html.erb
      format.json { render json: @photo }
    end
  end
  
  # GET /submit
  def new    
    if !current_user
      redirect_to root_path, notice: "Sorry, but you must be logged in before you can make submissions."
      return
    end
    
    @photo = Photo.new
    @photo.remote_image_url = params[:media] if params[:media]
    @photo.source_url = params[:url] if params[:url]
    
    @from_cuddlet = false
    @from_cuddlet = true if request.fullpath == '/submit'

    respond_to do |format|
      format.html { render layout: false } # new.html.erb
      #format.json { render json: @photo }
    end
  end
  
  # POST /submit
  # POST /submit.json
  def create
    redirect_to root_path && return if !current_user
    
    @photo = Photo.new(params[:photo])
    
    respond_to do |format|
      @photo.approved_at = Time.now if current_user.is_admin?

      if @photo.save
        format.html { render layout: false }#redirect_to root_path, notice: 'Your photo was successfully uploaded.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, notice: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Photo was successfully deleted." }
      format.json { head :no_content }
    end
  end

end
