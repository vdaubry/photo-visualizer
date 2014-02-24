class ImagesController < ApplicationController

  def index
    @website_id = params[:website_id]
    @post_id = params[:post_id]

    resp = JSON.parse(HTTParty.get("#{PHOTO_DOWNLOADER_URL}/websites/#{@website_id}/posts/#{@post_id}/images.json"))
    
    @to_sort_count = resp["meta"]["to_sort_count"]
    @to_keep_count = resp["meta"]["to_keep_count"]
    @to_delete_count = resp["meta"]["to_delete_count"]

    @images = resp["images"]


    # status = params["status"].nil? ? Image::TO_SORT_STATUS : params["status"]
    
    # if status==Image::TO_SORT_STATUS
    #   @images = @post.images.where(:status => status).asc(:created_at).page(params[:page])
    # else 
    #   @images = @website.images.where(:status => status).desc(:updated_at).page(params[:page])
    # end
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
