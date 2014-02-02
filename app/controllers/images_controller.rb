class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.where(:status => Image::TO_SORT_STATUS).page(params[:page])
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render action: 'show', status: :created, location: @image }
      else
        format.html { render action: 'new' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  def update
    FileUtils.mv "app/assets/images/to_sort/#{@image.key}", "ressources/to_keep/#{@image.key}"
    FileUtils.mv "app/assets/images/to_sort/thumbnails/300/#{@image.key}", "ressources/to_keep/thumbnails/300/#{@image.key}"
    @image.update_attributes(
      status: Image::TO_KEEP_STATUS,
    )

  end

  # DELETE /images/1
  def destroy
    FileUtils.mv "app/assets/images/to_sort/#{@image.key}", "ressources/to_delete/#{@image.key}"
    FileUtils.mv "app/assets/images/to_sort/thumbnails/300/#{@image.key}", "ressources/to_delete/thumbnails/300/#{@image.key}"
    @image.update_attributes(
      status: Image::TO_DELETE_STATUS,
    )
  end

  # DELETE /images/
  def destroy_all
    Image.where(:_id.in => params["image"]["ids"]).each do |image|
      if(File.exist?("app/assets/images/to_sort/#{image.key}"))
        FileUtils.mv "app/assets/images/to_sort/#{image.key}", "ressources/to_delete/#{image.key}"
        FileUtils.mv "app/assets/images/to_sort/thumbnails/300/#{image.key}", "ressources/to_delete/thumbnails/300/#{image.key}"
      end
      image.update_attributes(
        status: Image::TO_DELETE_STATUS,
      )
    end

    redirect_to images_url
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.permit(:id)
    end
end
