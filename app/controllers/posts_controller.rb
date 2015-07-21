class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_website


  def show
    @presenter = UserPostDecorator.new(website: @website, user: current_user, post: @post, params: params)
    @presenter.update_last_image_seen
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def set_website
      @website = @post.website
    end
end