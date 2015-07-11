class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :website, index: true
  has_many :images
  index({ created_at: 1 })

  field :name, type: String
  field :url
  
  validates :website_id, :name, :url, presence: true
  validates :url, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: {scope: :website} 
end
