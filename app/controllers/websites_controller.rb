class WebsitesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @websites = Website.all.page(params[:page]).per(50)
  end

end