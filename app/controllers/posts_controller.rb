class PostsController < ApplicationController
  before_action :set_website, only: [:destroy]
  before_action :set_post, only: [:destroy]

  def destroy
    @post.images.update_all(status: Image::TO_DELETE_STATUS)
    @post.update_attributes(:status => Post::SORTED_STATUS)

    redirect_to website_images_path(@post.website)
  end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_post
	  @post = @website.posts.find(params[:id])
	end

  def set_website
    @website = Website.find(params[:website_id])
  end

	# Never trust parameters from the scary internet, only allow the white list through.
	def post_params
	  params.require(:post).permit(:id, :name)
	end
end