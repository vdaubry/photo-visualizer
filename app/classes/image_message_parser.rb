class ImageMessageParser < Struct.new(:msg)
  def website_name
    website["name"]
  end

  def website_url
    website["url"]
  end

  def post_name
    post["name"]
  end

  def post_url
    post["url"]
  end

  def image_thumb_url
    image["thumb_url"]
  end

  def image_target_url
    image["target_url"]
  end

  def image_scrapped_at
    image["scrapped_at"]
  end

  private
    def infos
      @infos ||= JSON.parse(msg)
    end

    def website
      infos["website"]
    end

    def post
      infos["post"]
    end

    def image
      infos["image"]
    end
end