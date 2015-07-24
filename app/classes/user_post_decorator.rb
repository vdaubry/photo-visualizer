class UserPostDecorator
  def initialize(website:, user:, post:, params:)
    @website = website
    @user = user
    @post = post
    @params = params
  end

  def per
    25
  end

  def image_page
    @params[:image_page]
  end

  def posts
    @website.posts.page(@params[:post_page]).per(10)
  end

  def images
    @post.images.recent_last.page(current_page).per(per)
  end

  def favorites
    @user.user_images.in(id: images.map(&:id)).map(&:id)
  end

  def current_page
    return @current_page if @current_page
    return 0 if user_post.last_image_scrapped_at.nil?

    previous_images = @post.images.lt(scrapped_at: @user_post.last_image_scrapped_at)
    @current_page = previous_images.count/per
  end

  def update_last_image_seen
    user_post.update(last_image_scrapped_at: images.last.scrapped_at) if images.present?
  end

  def user_post
    @user_post ||= @user.user_posts.where(post_id: @post.id).first_or_create
  end
end