class User::WebsitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_website, only: [:update, :destroy]

  def index
    @websites = current_user.websites.page(params[:page]).per(50)
  end

  def update
    current_user.websites.push(@website)
    redirect_to websites_path
  end

  def destroy
    current_user.websites.delete(@website)
    redirect_to websites_path
  end

  private
    def set_website
      @website = Website.find(params[:id])
    end
end