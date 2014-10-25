class WebsitesController < ApplicationController
  def index
    resp = HTTParty.get("#{PHOTO_DOWNLOADER_URL}/websites.json")
    @websites = resp["websites"]

    resp = HTTParty.get("#{PHOTO_DOWNLOADER_URL}/zipfiles.json")
    @zipfiles = resp["zipfiles"]
  end
end
