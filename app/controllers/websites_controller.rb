class WebsitesController < ApplicationController
  def index
    resp = HTTParty.get("#{PHOTO_DOWNLOADER_URL}/websites.json")
    @websites = JSON.parse(resp)
  end
end
