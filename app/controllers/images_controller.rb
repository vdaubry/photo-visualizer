class ImagesController < ApplicationController
  before_action :set_website, only: [:index, :update, :destroy, :destroy_all, :redownload]
  before_action :set_post, only: [:index, :update, :destroy, :destroy_all, :redownload]
  before_action :set_image, only: [:update, :destroy, :redownload]

  def index
    @to_sort_count = @website.images.where(:status => Image::TO_SORT_STATUS).count
    @to_keep_count = @website.images.where(:status => Image::TO_KEEP_STATUS).count
    @to_delete_count = @website.images.where(:status => Image::TO_DELETE_STATUS).count

    status = params["status"].nil? ? Image::TO_SORT_STATUS : params["status"]
    
    if status==Image::TO_SORT_STATUS
      @images = @post.images.where(:status => status).asc(:created_at).page(params[:page])
    else 
      @images = @website.images.where(:status => status).desc(:updated_at).page(params[:page])
    end
  end

  def show
  end

  def update
    @image.update_attributes(
      status: Image::TO_KEEP_STATUS
    )

    @post.check_status!
  end

  def destroy
    @image.update_attributes(
      status: Image::TO_DELETE_STATUS
    )

    @post.check_status!
  end

  def destroy_all
    if params["image"] && params["image"]["ids"]
      @website.images.where(:_id.in => params["image"]["ids"]).update_all(
          status: Image::TO_DELETE_STATUS
      ) 
    end

    @post.check_status!
    next_post = @website.latest_post

    if next_post
      redirect_to website_post_images_url(@website, next_post)
    else
      redirect_to root_url
    end
  end 

  def redownload
    @image.download
  end
end
