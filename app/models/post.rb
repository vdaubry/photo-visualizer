class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :website, index: true
  has_many :images

  field :name, type: String
  field :url
  
  validates :website_id, :name, :url, presence: true
end
