class PostsController < ApplicationController
  before_action :set_website, only: [:destroy, :banish]

  def destroy
    resp = HTTParty.delete("#{PHOTO_DOWNLOADER_URL}/websites/#{params[:website_id]}/posts/#{params[:id]}.json")
    go_to_next_post(resp["latest_post"])
  end

  def banish
    resp = HTTParty.put("#{PHOTO_DOWNLOADER_URL}/websites/#{params[:website_id]}/posts/#{params[:id]}/banish.json")
    go_to_next_post(resp["latest_post"])
  end

  private

  def set_website
    @website = params[:website_id]
  end

  def go_to_next_post(latest_post)
    if latest_post
      redirect_to website_post_images_path(@website, latest_post, :status => "TO_SORT_STATUS")
    else
      redirect_to root_path
    end
  end


end