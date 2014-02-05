class PostsController < ApplicationController
  before_action :set_post, only: [:destroy]

  def destroy
    @post.images.update_all(status: Image::TO_DELETE_STATUS)
    @post.update_attribute(:status => Post::SORTED_STATUS)
    redirect_to website_images_path(@post.website)
  end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_post
	  @post = Post.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def post_params
	  params.require(:post).permit(:name)
	end
end