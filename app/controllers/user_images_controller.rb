class UserImagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @images = current_user.user_images.page(params[:page]).per(25)
    @favorites = @images.map(&:id)
  end

  def create
    image = Image.find(params[:id])
    user_image = UserImageBuilder.new(user: current_user, image: image).build
    render json: user_image.to_json, status: 201
  end
end