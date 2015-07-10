class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :website, index: true
  belongs_to :post, index: true
  
  field :thumb_url, type: String
  field :target_url, type: String
  field :scrapped_at, type: DateTime
  
  validates :website_id, :post_id, :thumb_url, :target_url, presence: true
end
