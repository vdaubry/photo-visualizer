class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :website, index: true
  belongs_to :post, index: true
  
  field :src, type: String
  field :href, type: String
  field :scrapped_at, type: DateTime
  index({ scrapped_at: 1 })
  
  validates :website_id, :post_id, :src, presence: true
  validates :src, uniqueness: true

  scope :recent_last, -> { order("scrapped_at ASC") }
end
