class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_website


  def show
    @posts = @website.posts
    @images = @post.images.recent_last.page(params[:page]).per(50)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def set_website
      @website = @post.website
    end
end