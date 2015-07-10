class WebsitesController < ApplicationController

  def index
    @websites = Website.all.page(params[:page]).per(50)
  end

end