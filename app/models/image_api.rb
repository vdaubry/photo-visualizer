class ImageAPI
  include HTTParty
  base_uri PHOTO_DOWNLOADER_URL

  attr_accessor :website, :post, :image

  def initialize(website_id, post_id, image_id=nil)
    self.website = website_id
    self.post = post_id
    self.image = image_id
  end

  def paginate(page, status)
    resp = self.class.get("/websites/#{website}/posts/#{post}/images.json", :query => {:page => page, :status => status})
    ImageIndex.new(resp)
  end

  def put
    resp = self.class.put("/websites/#{website}/posts/#{post}/images/#{image}.json")
    resp["status"]=="ok"
  end

  def delete
    self.class.delete("/websites/#{website}/posts/#{post}/images/#{image}.json")
  end

  def destroy_all(ids)
    resp = self.class.delete("/websites/#{website}/posts/#{post}/images/destroy_all.json", :query => {:ids => ids})
    resp["next_post_id"]
  end

  def redownload
    self.class.put("/websites/#{website}/posts/#{post}/images/#{image}/redownload.json")
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

  def post_name
    json["meta"]["post_name"]
  end

  def to_a
    json["images"]
  end
end