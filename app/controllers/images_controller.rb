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
    @image_id = params[:id]
    ImageAPI.new(params[:website_id], params[:post_id], @image_id).delete
  end

  def destroy_all
    ids = params["image"]["ids"] rescue nil
    next_post = ImageAPI.new(params[:website_id], params[:post_id], @image_id).destroy_all(ids)

    if next_post
      redirect_to website_post_images_url(params[:website_id], next_post)
    else
      redirect_to root_url
    end
  end 

  def redownload
    @image_id = params[:id]
    ImageAPI.new(params[:website_id], params[:post_id], @image_id).redownload
  end
end
