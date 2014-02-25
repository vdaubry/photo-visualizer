class ImagesController < ApplicationController

  def index
    @website_id = params[:website_id]
    @post_id = params[:post_id]

    image_api = ImageAPI.new(@website_id, @post_id)
    images = image_api.paginate(params[:page])
    
    @to_sort_count = images.to_sort_count
    @to_keep_count = images.to_keep_count
    @to_delete_count = images.to_delete_count

    @images = images.to_a
  end

  def update
    @image_id = params[:id]
    ImageAPI.new(params[:website_id], params[:post_id], @image_id).put
  end

  def destroy
    @image.update_attributes(
      status: Image::TO_DELETE_STATUS
    )

    @post.check_status!
  end

  def destroy_all
    ids = params["image"]["ids"] rescue nil
    @website.images.where(:_id.in => ids).update_all(status: Image::TO_DELETE_STATUS) unless ids.nil?

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
