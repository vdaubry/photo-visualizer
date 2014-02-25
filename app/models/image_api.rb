class ImageAPI
  include HTTParty
  base_uri PHOTO_DOWNLOADER_URL

  attr_accessor :website, :post, :image

  def initialize(website_id, post_id, image_id=nil)
    self.website = website_id
    self.post = post_id
    self.image = image_id
  end

  def paginate(page)
    resp = self.class.get("/websites/#{website}/posts/#{post}/images.json", {:page => page})
    ImageIndex.new(JSON.parse(resp))
  end

  def put
    self.class.put("/websites/#{website}/posts/#{post}/image/#{image}.json")
  end


end

class ImageIndex
  attr_accessor :json

  def initialize(json)
    self.json = json
  end

  def to_sort_count
    json["meta"]["to_sort_count"]
  end

  def to_keep_count
    json["meta"]["to_keep_count"]
  end

  def to_delete_count
    json["meta"]["to_delete_count"]
  end

  def to_a
    json["images"]
  end
end