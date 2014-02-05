require 'open-uri'

class Image
  TO_KEEP_STATUS="TO_KEEP_STATUS"
  TO_SORT_STATUS="TO_SORT_STATUS"
  TO_DELETE_STATUS="TO_DELETE_STATUS"
  DELETED_STATUS="DELETED_STATUS"
  KEPT_STATUS="KEPT_STATUS"

  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :website
  belongs_to :scrapping
  belongs_to :post

  field :key, type: String
  field :image_hash, type: String
  field :status, type: String
  field :file_size, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :source_url, type: String

  validates :key, :image_hash, :status, :file_size, :width, :height, :source_url, :website, presence: true, allow_blank: false, allow_nil: false
  validates_inclusion_of :status, in: [ TO_KEEP_STATUS, TO_SORT_STATUS, TO_DELETE_STATUS, DELETED_STATUS, KEPT_STATUS ]


  def build_info(source_url, website, scrapping, post)
    self.source_url = source_url
    self.website = website
    self.scrapping = scrapping
    self.key = DateTime.now.to_i.to_s + "_" + File.basename(URI.parse(source_url).path)
    self.status = Image::TO_SORT_STATUS
    self
  end

  # def key
  #   Rails.env.development? ? "calinours.jpg" : self[:key]
  # end

  def self.image_path
    "app/assets/images/to_sort"
  end

  def self.thumbnail_path
    "app/assets/images/to_sort/thumbnails/300"
  end

  def self.asset_thumbnail_path
    "to_sort/thumbnails/300"
  end  

  def download
    file_path = "#{image_path}/#{self[:key]}"
    open(file_path, 'wb') do |file|
     file << open(source_url).read
    end

    image = MiniMagick::Image.open(file_path) 
    image.resize "300x300"
    image.write  "#{thumbnail_path}/#{self[:key]}"

    image_file = File.read(file_path)
    self.image_hash = Digest::MD5.hexdigest(image_file)
    self.width = FastImage.size(file_path)[0]
    self.height = FastImage.size(file_path)[1]
    self.file_size = image_file.size
    save!
  end
end
