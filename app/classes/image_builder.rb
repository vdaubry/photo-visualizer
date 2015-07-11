class ImageBuilder
  def initialize(image_message_parser:)
    @parser = image_message_parser
  end

  def create
    Image.create(thumb_url: @parser.image_thumb_url,
                  target_url: @parser.image_target_url,
                  scrapped_at: @parser.image_scrapped_at,
                  website: website,
                  post: post)
  end

  def website
    @website ||= Website.where(url: @parser.website_url).first || 
                  Website.create(name: @parser.website_name, url: @parser.website_url)
  end

  def post
    @post ||= Post.where(url: @parser.post_url).first || 
              Post.create(name: @parser.post_name, url: @parser.post_url, website: website)
  end
end