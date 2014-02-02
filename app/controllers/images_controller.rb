class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @to_sort_count = Image.where(:status => Image::TO_SORT_STATUS).count
    @to_keep_count = Image.where(:status => Image::TO_KEEP_STATUS).count
    @to_delete_count = Image.where(:status => Image::TO_DELETE_STATUS).count

    status = params["status"].nil? ? Image::TO_SORT_STATUS : params["status"]
    @images = Image.where(:status => status).page(params[:page])

    if status==Image::TO_SORT_STATUS
      @images = @images.asc(:created_at)
    else 
      @images = @images.desc(:updated_at)
    end
    
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
    @image.update_attributes(
      status: Image::TO_KEEP_STATUS
    )

  end

  # DELETE /images/1
  def destroy
    @image.update_attributes(
      status: Image::TO_DELETE_STATUS
    )
  end

  # DELETE /images/
  def destroy_all
    Image.where(:_id.in => params["image"]["ids"]).update_all(
        status: Image::TO_DELETE_STATUS
      )

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
