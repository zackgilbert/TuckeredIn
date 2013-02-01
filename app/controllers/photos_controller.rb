class PhotosController < ApplicationController
  before_filter :admins_only, :only => [:pending, :edit, :create, :update, :destroy]

  # GET /
  # GET /home
  def index
    @current_page = params[:page]
    @current_page ||= '1'
    @next_page = 0
    if params[:tag]
      @photos = Photo.where("approved_at IS NOT NULL").order("approved_at DESC").tagged_with(params[:tag]).page @current_page
    else
      @photos = Photo.where("approved_at IS NOT NULL").order("approved_at DESC").page @current_page
    end
    @next_page = @current_page.to_i+1 if @photos.length >= 25

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /pending
  def pending
    @current_page = params[:page]
    @current_page ||= '1'
    @next_page = 0
    @photos = Photo.where("approved_at IS NULL").order("created_at DESC").page @current_page
    @next_page = @current_page.to_i+1 if @photos.length >= 25

    respond_to do |format|
      format.html { render action: :index }
      format.json { render json: @photos }
    end
  end

  # GET /cuties/1
  # GET /cuties/1.json
  def show
    if request.xhr?
      @photo = Photo.find(params[:id])

      respond_to do |format|
        format.html { render layout: false }
        format.json { render json: @photo }
      end
    else
      @current_page = '1'
      @next_page = 0
      @photos = Photo.where("approved_at IS NOT NULL").order("approved_at DESC").page @current_page
      @next_page = @current_page.to_i+1 if @photos.length >= 25
      @photo = Photo.find(params[:id])

      respond_to do |format|
        format.html { render action: :index }
        format.json { render json: @photo }
      end
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html { }#render layout: false } # show.html.erb
    end
  end

  # FINISH!!!
  # POST /charge
  def charge
    @amount = 1000

    customer = Stripe::Customer.create(
      :email => params[:email],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Tuckered.In (1 Year)',
      :currency    => 'usd'
    )
    flash[:notice] = "Thanks for subscribing! You should receive a confirmation email in a few minutes."
    redirect_to thankyou_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to subscribe_path
  end

  # BUILD OUT!
  # GET /charges
  def charges
    if request.xhr?
      render :layout => false
    else
      @current_page = '1'
      @next_page = 0
      @photos = Photo.where("approved_at IS NOT NULL").order("approved_at DESC").page @current_page
      @next_page = @current_page.to_i+1 if @photos.length >= 25

      respond_to do |format|
        format.html { render action: :index }
        format.json { render json: false }
      end
    end
  end

  # GET /subscribe
  def subscribe
    if request.xhr?
      render :layout => false
    else
      @current_page = '1'
      @next_page = 0
      @photos = Photo.where("approved_at IS NOT NULL").order("approved_at DESC").page @current_page
      @next_page = @current_page.to_i+1 if @photos.length >= 25

      respond_to do |format|
        format.html { render action: :index }
        format.json { render json: false }
      end
    end
  end

  # GET /thankyou
  def thankyou
    if request.xhr?
      render :layout => false
    else
      @current_page = '1'
      @next_page = 0
      @photos = Photo.where("approved_at IS NOT NULL").order("approved_at DESC").page @current_page
      @next_page = @current_page.to_i+1 if @photos.length >= 25

      respond_to do |format|
        format.html { render action: :index }
        format.json { render json: false }
      end
    end
  end

  # GET /upload
  def new
    if request.xhr?
      @photo = Photo.new
      @photo.remote_image_url = params[:media] if params[:media]
      @photo.source_url = params[:url] if params[:url]

      @from_cuddlet = false
      @from_cuddlet = true if request.fullpath[0...7] == '/submit'

      respond_to do |format|
        format.html { render layout: false } # new.html.erb
        #format.json { render json: @photo }
      end
    else
      @current_page = '1'
      @next_page = 0
      @photos = Photo.where("approved_at IS NOT NULL").order("approved_at DESC").page @current_page
      @next_page = @current_page.to_i+1 if @photos.length >= 25

      respond_to do |format|
        format.html { render action: :index }
        format.json { render json: @photos }
      end
    end
  end

  # POST /upload
  # POST /upload.json
  def upload
    if (!params[:photo][:remote_image_url].blank?) && (!['.gif', '.png', '.jpg', '.jpeg'].include?(File.extname(params[:photo][:remote_image_url])))
      # mail it to Zack!
      redirect_to root_path, notice: "Sorry, but you must send us actual images."
      return
    end

    @photo = Photo.new(params[:photo])
    @photo.tag_list = params[:tags]

    respond_to do |format|
      #@photo.approved_at = Time.now if current_user.is_admin?

      if @photo.save
        format.html { redirect_to root_path, notice: 'Your photo was successfully submitted. Check back to see if it gets added!' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, notice: :unprocessable_entity }
      end
    end
  end

  # GET /submit
  def submit
    if !current_user
      redirect_to "/login"
      return
    end

    @photo = Photo.new
    @photo.remote_image_url = params[:media] if params[:media]
    @photo.source_url = params[:url] if params[:url]

    @from_cuddlet = false
    @from_cuddlet = true if request.fullpath[0...7] == '/submit'

    respond_to do |format|
      format.html { render layout: false } # new.html.erb
      #format.json { render json: @photo }
    end
  end

  # POST /submit
  # POST /submit.json
  def create
    @photo = Photo.new(params[:photo])
    @photo.tag_list = params[:tags]

    respond_to do |format|
      #@photo.approved_at = Time.now if current_user.is_admin?

      if @photo.save
        format.html { render layout: false }#redirect_to root_path, notice: 'Your photo was successfully uploaded.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, notice: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/:id
  # PUT /photos/:id.json
  def update
    @photo = Photo.find(params[:id])
    @photo.tag_list = params[:tags]

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
          format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @photo.errors, status: :unprocessable_entity }
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

  # POST /photos/1/like
  # POST /photos/1/like.json
  def like
    redirect_to root_path, notice: "You must be logged in to like photos." if !current_user

    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.liked_by current_user
        format.html { redirect_to @photo, notice: "Photo was successfully liked." }
        format.json { render json: @photo.likes.size, status: :created, location: @photo }
      else
        format.html { redirect_to @photo, notice: "Our apologies, but we were unable to like this photo for you." }
        format.json { render json: { errors: "Our apologies, but we were unable to like this photo for you." }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1/unlike
  # DELETE /photos/1/unlike.json
  def unlike
    redirect_to root_path, notice: "You must be logged in to unlike photos." if !current_user

    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.unvote(:voter => current_user)
        format.html { redirect_to @photo, notice: "Photo was successfully unliked." }
        format.json { render json: @photo.likes.size }
      else
        format.html { redirect_to @photo, notice: "Our apologies, but we were unable to unlike this photo for you." }
        format.json { head :no_content }
      end
    end
  end

  # POST /photos/1/approve
  def approve
    redirect_to root_path, notice: "You must be an admin to approve photos." if !current_user || !current_user.is_admin?

    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes({ approved_at: Time.now })
        format.html { redirect_to root_path, notice: 'Photo was successfully approved.' }
        format.json { head :no_content }
      else
        format.html { redirect_to pending_path, notice: 'Photo was NOT approved.' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1/unapprove
  def unapprove
    redirect_to root_path, notice: "You must be logged in to unlike photos." if !current_user

    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes({ approved_at: nil })
        format.html { redirect_to pending_path, notice: 'Photo was successfully unapproved.' }
        format.json { head :no_content }
      else
        format.html { redirect_to root_path, notice: 'Photo was NOT unapproved.' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

end
