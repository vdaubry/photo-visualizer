class PostsController < ApplicationController
  def destroy
    resp = HTTParty.get("#{PHOTO_DOWNLOADER_URL}/websites/#{params[:website_id]}/posts/#{params[:id]}.json")

    latest_post = JSON.parse(resp)["latest_post"]
    if latest_post
      redirect_to website_post_images_path(params[:website_id], latest_post)
    else
      redirect_to root_path
    end
  end
end